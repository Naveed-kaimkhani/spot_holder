
// import 'package:flutter/material.dart';

// import '../Domain/models/seller_model.dart';

// class SellerProvider with ChangeNotifier {
//   SellerModel? _sellerDetails;
//   SellerModel? get seller => _sellerDetails;


//   Future getSellerLocally() async {

//     _sellerDetails = await StorageService.readSeller();
//     notifyListeners();
//   }

//   Future getSellerFromServer(context) async {
//     print("getSellerFromServer");
//     _sellerDetails = await firebaseRepository.getSeller();
//     if (_sellerDetails == null) {
//       utils.flushBarErrorMessage("No user found",context);
//     }
//     notifyListeners();
//   }
// // }
