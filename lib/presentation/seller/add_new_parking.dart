// import 'dart:typed_data';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:spot_holder/Data/network_utility.dart';
import 'package:spot_holder/Domain/models/parking_model.dart';
import 'package:spot_holder/Domain/models/rider_model.dart';
import 'package:spot_holder/Domain/models/user_model.dart';
import 'package:spot_holder/utils/Dialogues/parking_done_popup.dart';
import 'package:spot_holder/utils/custom_loader.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../Data/FirebaseUserRepository.dart';
import '../../Domain/models/place_autoComplete_response.dart';
import '../../data/notification_services.dart';
import '../../provider/user_provider.dart';
import '../../style/custom_text_style.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widget/auth_button.dart';
import '../widget/circle_progress.dart';
import '../widget/input_field.dart';

class AddNewParking extends StatefulWidget {
  const AddNewParking({Key? key}) : super(key: key);

  @override
  State<AddNewParking> createState() => _AddNewParkingState();
}

class _AddNewParkingState extends State<AddNewParking> {
  UserModel? user;
  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  final _formKey = GlobalKey<FormState>();
  NotificationServices notificationServices = NotificationServices();
  List<AutoCompletePrediction>? placePrediction = [];

  // Uint8List? _profileImage;
  bool? obsecureText = true;
  bool isLoadingNow = false;
  bool _obsecureText = true;
  // Uint8List? _profileImage;

  FocusNode nameFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode _numberOfSlotsFocusNode = FocusNode();

  FocusNode _priceFocusNode = FocusNode();

  FocusNode descriptionFocusNode = FocusNode();
  // FocusNode confirmFocusNode = FocusNode();
  // FocusNode passwordFocusNode = FocusNode();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfSlotsController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  Widget k = SizedBox(
    height: 16.h,
  );
  EdgeInsetsGeometry l = EdgeInsets.only(left: 12.w, top: 8.h);
  void isLoading(bool value) {
    setState(() {
      isLoadingNow = value;
    });
  }

  List<XFile>? parkingImageList = [];
  void selectImages() async {
    final selectedImaged = await ImagePicker().pickMultiImage();
    if (selectedImaged.isNotEmpty) {
      parkingImageList!.addAll(selectedImaged);
    }
    setState(() {});
  }

  void _submitForm() {
    if (parkingImageList!.isEmpty) {
      utils.flushBarErrorMessage("Upload parking images", context);
    } else if (_formKey.currentState!.validate()) {
      // Form is valid, perform signup logic here
      _saveParking();
      // Perform signup logic
      // ...
    }
  }

  String apiKey = "https://maps.googleapis.com";
  String unencoder = "maps/api/place/autocomplete/json";

  void _saveParking() async {
    LoaderOverlay.show(context);
    final parkingId = utils.getRandomid();
    List<String> pictures = await FirebaseUserRepository.uploadDonationImage(
        imageFile: parkingImageList!, donationId: parkingId);
    final location =
        await _firebaseUserRepository.getUserCurrentLocation(context);
    final String address = await utils.getAddressFromLatLng(
        location!.latitude, location.longitude);
    ParkingModel parkingModel = ParkingModel(
      ownerName: user!.name ?? "No Name",
      ownerUid: user!.uid,
      locationLat: location.latitude,
      locationLong: location.longitude,
      pictures: pictures,
      ownerPhone: user!.phone!,
      parkingId: parkingId,
      price: int.parse(_priceController.text),
      ownerProfileImage: user!.profileImage!,
      availableSlots: int.parse(_numberOfSlotsController.text),
      bookedSlots: 0,
      parkingAddress: address,
      sentDate: utils.getCurrentDate(),
      sentTime: utils.getCurrentTime(),
      parkingDescription: descriptionController.text,
      ownerDeviceToken: await notificationServices.getDeviceToken(),
    );

    await FirebaseUserRepository.saveParkingModelToFirestore(
        parkingModel, context);
    LoaderOverlay.hide();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    locationFocusNode.dispose();
    _numberOfSlotsFocusNode.dispose();
    _priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    _priceController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _numberOfSlotsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    utils.checkConnectivity(context);
    super.initState();
  }

  placeAutoComplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        "maps/api/place/autocomplete/json",
        {"input": query, "key": "AIzaSyB_uj7e2Au3zoDSB0kLeBrio2Q_QKjlWmM"});
    print(uri);
    String? responseBody = await NetworkUtility.fetchUrl(uri);
    if (responseBody != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutoCompleteResult(responseBody);
      if (result.predictions != null) {
        setState(() {
          placePrediction = result.predictions;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).seller;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButton(),
                  Center(
                    child: Image.asset(
                      Images.logo,
                      height: 100.h,
                      width: 200.w,
                    ),
                  ),
                  // SizedBox(
                  //   height: 6.h,
                  // ),

                  parkingImageList!.isNotEmpty
                      ? SizedBox(
                          height: 100.h,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: parkingImageList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(
                                    File(parkingImageList![index].path),
                                    fit: BoxFit.cover,
                                    height: 100.h,
                                    width: 50.w,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            InkWell(
                              child: Image.asset(
                                "assets/map.png",
                                height: 60.h,
                                width: 60.w,
                              ),
                              onTap: () => selectImages(),
                            ),
                            const Center(
                              child: Text("Location Images"),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: l,
                    child: Text(
                      "Enter Address",
                      style: CustomTextStyle.font_12_grey,
                    ),
                  ),
                  InputField(
                    hint_text: "Qasimabad",
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: locationFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: l,
                    child: Text(
                      "No. of slots",
                      style: CustomTextStyle.font_12_grey,
                    ),
                  ),
                  InputField(
                    hint_text: "eg 18",
                    currentNode: _numberOfSlotsFocusNode,
                    focusNode: _numberOfSlotsFocusNode,
                    nextNode: _priceFocusNode,
                    keyboardType: TextInputType.number,
                    controller: _numberOfSlotsController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter slots";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: l,
                    child: Text(
                      "Enter price/hr",
                      style: CustomTextStyle.font_12_grey,
                    ),
                  ),
                  InputField(
                    hint_text: "30 pkr",
                    currentNode: _priceFocusNode,
                    focusNode: _priceFocusNode,
                    nextNode: descriptionFocusNode,
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter price/hr";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: l,
                    child: Text(
                      "Parking Description",
                      style: CustomTextStyle.font_12_grey,
                    ),
                  ),

                  InputField(
                    hint_text: "Description",
                    currentNode: descriptionFocusNode,
                    focusNode: descriptionFocusNode,
                    nextNode: descriptionFocusNode,
                    controller: descriptionController,
                    obsecureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Description";
                      }
                    },
                  ),
                  // Padding(
                  //   padding: l,
                  //   child: Text(
                  //     "Parking Description",
                  //     style: CustomTextStyle.font_12_grey,
                  //   ),
                  // ),

                  // Container(
                  //   height: 64.h,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20.r),
                  //   ),
                  //   padding: EdgeInsets.all(12.w),
                  //   child: TextFormField(
                  //     controller: _locationController,
                  //     style: const TextStyle(
                  //         color: Colors.black,
                  //         fontFamily: "Sansita",
                  //         fontSize: 16),
                  //     keyboardType: TextInputType.text,
                  //     // obscureText: obsecureText ?? false,
                  //     // controller: controller,
                  //     cursorColor: Colors.black,
                  //     // // focusNode: focusNode,
                  //     // onEditingComplete: () => utils.fieldFocusChange(
                  //     //     context, locationFocusNode, locationFocusNode),
                  //     decoration: InputDecoration(
                  //       fillColor: Styling.textfieldsColor,
                  //       filled: true,
                  //       contentPadding: const EdgeInsets.all(12),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12.r),
                  //         borderSide:
                  //             const BorderSide(color: Colors.black, width: 1.0),
                  //       ),
                  //       border: InputBorder.none,
                  //       hintText: "Enter Location",
                  //       hintStyle: TextStyle(
                  //         color: const Color.fromARGB(255, 112, 102, 102),
                  //         fontSize: 17.sp,
                  //       ),
                  //       prefixIcon: const Icon(Icons.location_on_outlined),
                  //       // suffixIcon: InkWell(
                  //       //   onTap: onIconPress,
                  //       //   // child: Icon(
                  //       //   //   icon,
                  //       //   //   color: const Color.fromARGB(255, 65, 61, 61),
                  //       //   // ),
                  //       // ),
                  //     ),
                  //     // validator: validator,
                  //     onChanged: (value) {
                  //       placeAutoComplete(value);
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: isLoadingNow
                        ? const CircleProgress()
                        : AuthButton(
                            height: 46.h,
                            widht: 300.w,
                            text: "Add Parking Space",
                            func: () {
                              // placeAutoComplete("Dubai");
                              FocusManager.instance.primaryFocus?.unfocus();

                              _submitForm();
                            },
                            color: Styling.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onIconPress() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }
  // for 1st image
}
