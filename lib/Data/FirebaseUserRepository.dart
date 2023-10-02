import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spot_holder/provider/parking_list_provider.dart';
import 'package:spot_holder/utils/custom_loader.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../Domain/transaction.dart';

import '../Domain/models/parking_model.dart';
import '../Domain/models/reserved_parking_model.dart';
import '../Domain/models/rider_model.dart';
import '../Domain/models/user_model.dart';
import '../provider/user_provider.dart';
import '../utils/Dialogues/parking_done_popup.dart';

class FirebaseUserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection('users');

  static final CollectionReference _transactionCollection =
      firestore.collection('transactions');

  static final CollectionReference _sellerCollection =
      firestore.collection('sellers');

  static final CollectionReference _parkingCollection =
      firestore.collection('parkings');

  static final CollectionReference _reservedParkingCollection =
      firestore.collection('reserved_parkings');
  static final Reference _storageReference = FirebaseStorage.instance.ref();
  // NotificationServices _notificationServices = NotificationServices();
  Future<User?> login(String email, String password, context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      utils.flushBarErrorMessage("Invalid email or password", context);
    }
  }

  static Future<List<ParkingModel>> getParkingSpots(
    context,
  ) async {
    List<ParkingModel> parkingList = [];

    print("in getParking");
    try {
      print("in try");
      QuerySnapshot querySnapshot = await _parkingCollection.get();
      print(querySnapshot.docs[0]);
      parkingList = querySnapshot.docs.map((doc) {
        print(doc);
        return ParkingModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donations: $e', context);
    }
    return parkingList;
  }

  static Stream<List<ParkingModel>> getParkingList(context, bool all) async* {
    List<ParkingModel> parkingList = [];

    try {
      if (all) {
        QuerySnapshot querySnapshot = await _parkingCollection.get();
        parkingList = querySnapshot.docs.map((doc) {
          return ParkingModel.fromMap(doc.data() as dynamic);
        }).toList();
      } else {
        QuerySnapshot querySnapshot = await _parkingCollection
            .where('ownerUid', isEqualTo: utils.currentUserUid)
            .get();
        parkingList = querySnapshot.docs.map((doc) {
          return ParkingModel.fromMap(doc.data() as dynamic);
        }).toList();
      }
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donations: $e', context);
    }
    yield parkingList;
  }

  static Stream<List<ReservedParkingModel>> getReservedParkings( String query,
      context) async* {
    List<ReservedParkingModel> parkingList = [];

    try {
      QuerySnapshot querySnapshot = await _reservedParkingCollection
          .where(query, isEqualTo: utils.currentUserUid)
          .get();
      parkingList = querySnapshot.docs.map((doc) {
        return ReservedParkingModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching parkings: $e', context);
    }
    yield parkingList;
  }
  
  // static Stream<List<ReservedParkingModel>> getReservedParkingsStatus(
  //     context) async* {
  //   List<ReservedParkingModel> parkingList = [];

  //   try {
  //     QuerySnapshot querySnapshot = await _reservedParkingCollection
  //         .where('ownerUid', isEqualTo: utils.currentUserUid)
  //         .get();
  //     parkingList = querySnapshot.docs.map((doc) {
  //       return ReservedParkingModel.fromMap(doc.data() as dynamic);
  //     }).toList();
  //   } catch (e) {
  //     utils.flushBarErrorMessage('Error fetching parkings: $e', context);
  //   }
  //   yield parkingList;
  // }

  static Stream<List<TransactionModel>> getTransactionHistory(context) async* {
    List<TransactionModel> historyList = [];

    try {
      QuerySnapshot querySnapshot = await _transactionCollection
          .where('senderUid', isEqualTo: utils.currentUserUid)
          .get();
      historyList = querySnapshot.docs.map((doc) {
        return TransactionModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching history: $e', context);
    }
    yield historyList;
  }
  
  static Stream<List<TransactionModel>> getTransactionHistoryForSeller(context) async* {
    List<TransactionModel> historyList = [];

    try {
      QuerySnapshot querySnapshot = await _transactionCollection
          .where('receiverUid', isEqualTo: utils.currentUserUid)
          .get();
      historyList = querySnapshot.docs.map((doc) {
        return TransactionModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching history: $e', context);
    }
    yield historyList;
  }

  Future<String> uploadProfileImage(
      {required Uint8List? imageFile, required String uid}) async {
    await _storageReference
        .child('profile_images')
        .child(uid)
        .putData(imageFile!);
    String downloadURL =
        await _storageReference.child('profile_images/$uid').getDownloadURL();
    return downloadURL;
  }

  Future<void> saveUserDataToFirestore(RiderModel userModel) async {
    await _userCollection.doc(userModel.uid).set(userModel.toMap(userModel));
  }

  Future<void> saveSellerDataToFirestore(RiderModel userModel) async {
    await _sellerCollection.doc(userModel.uid).set(userModel.toMap(userModel));
  }

  Future<Position?> getUserCurrentLocation(context) async {
    try {
      print("getUserCurrentLocation");
      await Geolocator.requestPermission();
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Location Permission Required"),
              content: const Text(
                "Please enable location permission from the app settings to access your current location.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
      return await Geolocator.getCurrentPosition();
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      return null; // or throw the error
    }
  }

  Future<User?> signUpUser(String email, String password, context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      utils.flushBarErrorMessage(error.message.toString(), context);
    }
    return null;
  }

  loadUserDataOnAppInit(context) async {
    try {
      final value = await getUserCurrentLocation(context);
      String address =
          await utils.getAddressFromLatLng(value!.latitude, value.longitude);
      await updateUserLocation(value.latitude, value.longitude, address);
      await Provider.of<UserProvider>(context, listen: false)
          .getUserFromServer(context);
      await Provider.of<ParkingListProvider>(context, listen: false)
          .getParkingList(context);

      // Navigate to the home screen after loading the data
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      // Handle error if any
    }
  }

  Future<UserModel?> getUser() async {
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    // var response = await http.get(url);
    // var list = jsonDecode(response.body) as List;
    // return list.map((e) => UserJson.fromJson(e).toDomain()).toList();
    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      UserModel? userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      if (userModel != null) {
        return userModel;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<UserModel?> getSeller() async {
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    // var response = await http.get(url);
    // var list = jsonDecode(response.body) as List;
    // return list.map((e) => UserJson.fromJson(e).toDomain()).toList();
    DocumentSnapshot documentSnapshot =
        await _sellerCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      UserModel? userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      if (userModel != null) {
        return userModel;
      } else {
        return null;
      }
    }
    return null;
  }

  static Future<List<String>> uploadDonationImage(
      {required List<XFile> imageFile, required String donationId}) async {
    int id = 1;
    List<String> listOfDonationImages = [];
    for (XFile element in imageFile) {
      XFile compressedImage = await utils.compressImage(element);
      final imageRef = _storageReference
          .child('parking_images')
          .child(utils.currentUserUid)
          // .child(DateTime.now().millisecondsSinceEpoch.toString())
          .child(donationId)
          .child(id.toString());

      await imageRef.putFile(File(compressedImage.path));

      String downloadURL = await imageRef.getDownloadURL();
      listOfDonationImages.add(downloadURL);
      id++;
    }

    return listOfDonationImages;
  }

  static Future<void> saveParkingModelToFirestore(
      ParkingModel parking, context) async {
    try {
      // Reference to the "donations" collection
      // CollectionReference parkingCollection =
      //     FirebaseFirestore.instance.collection('parkings');

      // Convert the donationModel to a Map
      Map<String, dynamic> parkingData = parking.toMap(parking);

      // Add the donation data as a new document in the "donations" collection
      DocumentReference parkingRef = await _parkingCollection.add(parkingData);

      // Get the ID of the newly added document and store it in the donationData map
      String documentId = parkingRef.id;
      // parkingData['documentId'] = documentId;

      // Update the document with the added document ID
      await parkingRef.update({'documentId': documentId});
      // utils.toastMessage('Donation stored successfully!');
      parkingDonePopup(context, 'Parking added Successfully');
      // print('Donation stored successfully!');
    } catch (e) {
      LoaderOverlay.hide();
      utils.toastMessage('Error storing donation: $e');
      // print('Error storing donation: $e');
    }
  }

  static Future<void> bookParkingModelToFirestore(
      ReservedParkingModel parking, context) async {
    try {
      // Reference to the "donations" collection
      // CollectionReference parkingCollection =
      //     FirebaseFirestore.instance.collection('parkings');

      // Convert the donationModel to a Map
      Map<String, dynamic> parkingData = parking.toMap(parking);

      // Add the donation data as a new document in the "donations" collection
      DocumentReference parkingRef =
          await _reservedParkingCollection.add(parkingData);

      // Get the ID of the newly added document and store it in the donationData map
      String documentId = parkingRef.id;
      // parkingData['documentId'] = documentId;

      // Update the document with the added document ID
      await parkingRef.update({'documentId': documentId});
      // utils.toastMessage('Donation stored successfully!');
      // print('Donation stored successfully!');
    } catch (e) {
      LoaderOverlay.hide();
      utils.toastMessage('Error booking parking: $e');
      // print('Error storing donation: $e');
    }
  }

  static Future<void> updateSlots(String parkingDocumentId, int availableSlots,
      int slotsBooked, context) async {
    try {
      // Reference to the parking document in Firestore
      DocumentReference parkingRef = _parkingCollection.doc(parkingDocumentId);
      int left = availableSlots - slotsBooked;
      // Update the bookedSlots field
      await parkingRef
          .update({'bookedSlots': slotsBooked, 'availableSlots': left});

      // Success message or further actions
      utils.toastMessage('Slots updated successfully!');
    } catch (e) {
      LoaderOverlay.hide();
      utils.toastMessage('Error updating Slots: $e');
    }
  }

  static Future<void> updateBalance(String userId, int userUpdatedBalance,
      int paymentTobeAdd, String sellerId, context) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('sellers') // Replace with your collection name
          .doc(sellerId) // Provide the user's document ID or path
          .get();
      final userData = userDoc.data() as Map<String, dynamic>;
      final balance = userData['balance'];
      final totalBalance = balance + paymentTobeAdd;

      DocumentReference sellerRef = _sellerCollection.doc(sellerId);
      // Update the balance field
      await sellerRef.update({'balance': totalBalance});

      // Reference to the user document in Firestore
      DocumentReference userRef = _userCollection.doc(userId);
      // Update the balance field
      await userRef.update({'balance': userUpdatedBalance});
    } catch (e) {
      print("error in updateBalance");
      print(e);
      LoaderOverlay.hide();
      // utils.toastMessage('Error during Transaction: $e');
    }
  }

  static Future<void> saveTransaction(TransactionModel model, context) async {
    try {
      //save transaction to firestore
      Map<String, dynamic> transactionData = model.toMap(model);

      DocumentReference transactionRef =
          await _transactionCollection.add(transactionData);
      // Get the ID of the newly added document and store it in the donationData map
      String documentId = transactionRef.id;
      // parkingData['documentId'] = documentId;

      // Update the document with the added document ID
      await transactionRef.update({'documentId': documentId});
      // Success message or further actions
      // utils.toastMessage(' Transaction successfull!');

      parkingDonePopup(context, 'Parking book Successfully');
      // print('Donation stored successfully!');
    } catch (e) {
      print("error in transaction");
      print(e);
      LoaderOverlay.hide();
      // utils.toastMessage('Error storing donation: $e');
      // print('Error storing donation: $e');
    }
  }

  Future<void> updateUserLocation(
    double lat,
    double long,
    String address,
  ) async {
    try {
      final userRef = _userCollection.doc(utils.currentUserUid);

      await userRef.update({
        'lat': lat,
        'long': long,
        'address': address,
      });
    } catch (e) {
      utils.toastMessage(e.toString());
    }
  }

  
// Update rider's location in Firestore
static Future<void> updateRiderLocation(double latitude, double longitude,) async{
  FirebaseFirestore.instance.collection('users').doc(utils.currentUserUid).update({
    'lat': latitude,
    'long': longitude,
    // Add any additional rider information you need to update
  });
}
}
