import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spot_holder/presentation/seller/seller_navigation.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../Data/FirebaseUserRepository.dart';
import '../../Domain/models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../widget/auth_button.dart';
import '../widget/circle_progress.dart';
import '../widget/profile_pic.dart';
import '../widget/update_profile_field.dart';

class UpdateSellerProfile extends StatefulWidget {
  const UpdateSellerProfile({Key? key}) : super(key: key);

  @override
  State<UpdateSellerProfile> createState() => _UpdateSellerProfileState();
}

class _UpdateSellerProfileState extends State<UpdateSellerProfile> {
  @override
  void initState() {
    _nameController.text = "";
    _nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: _nameController.text.length));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    cityFocusNode.dispose();
    _phoneController.dispose();
    _cityController.dispose();
  }

  bool isLoadingNow = false;
  Uint8List? _UpdateSellerProfileImage;
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final FirebaseUserRepository _FirebaseUserRepository =
      FirebaseUserRepository();
  SizedBox spaceBtwHeadnField = SizedBox(
    height: 0.h,
  );
  SizedBox spaceAfterEveryField = SizedBox(
    height: 18.h,
  );
  EdgeInsetsGeometry k = EdgeInsets.only(
    left: 10.h,
    right: 10.h,
    // top: 10.h,
  );
  final users = FirebaseFirestore.instance.collection('sellers');
  UserModel? user;
  Future<String> updateUpdateSellerProfile() async {
    String UpdateSellerProfileUrl =
        await _FirebaseUserRepository.uploadProfileImage(
            imageFile: _UpdateSellerProfileImage!, uid: utils.currentUserUid);
    return UpdateSellerProfileUrl;
  }

  void isLoading(bool value) {
    setState(() {
      isLoadingNow = value;
    });
  }

  Future<void> updateData() {
    final uid = utils.currentUserUid;
    if (_UpdateSellerProfileImage != null) {
      updateUpdateSellerProfile()
          .then((url) => {
                users.doc(uid).update({
                  "profileImage": url,
                }),
                debugPrint('Data updated'),
              })
          .onError((error, stackTrace) => {
                utils.flushBarErrorMessage(error.toString(), context),
                isLoading(false),
              });
    }

    return users
        .doc(uid)
        .update({
          "name":
              _nameController.text.isEmpty ? user!.name : _nameController.text,
          "phone": _phoneController.text.isEmpty
              ? user!.phone
              : _phoneController.text,
          "address": _cityController.text.isEmpty
              ? user!.address
              : _cityController.text,
        })
        .then((value) => {
              isLoading(false),
              utils.toastMessage('Profile Updated'),
            })
        .onError((error, stackTrace) => {
              isLoading(false),
              utils.flushBarErrorMessage(error.toString(), context),
            });
  }

  Future<void> _getUserDetails(String uid) async {
    try {
      await utils.clearImageCache(user!.profileImage!);
      await Provider.of<UserProvider>(context, listen: false)
          .getSellerFromServer(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const SellerNavigation();
      }));
    } catch (e) {
      utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).seller;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Styling.primaryColor,
            title: const Text('Update Profile'),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HomeHeader(barTitle: "Update Profile", height: 90.h),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: UploadUpdateSellerProfile(_UpdateSellerProfileImage),
                ),
                SizedBox(
                  height: 23.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Your Name",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                spaceBtwHeadnField,
                Padding(
                  padding: k,
                  child: UpdateProfileField(
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: cityFocusNode,
                    hint_text: user!.name!,
                    controller: _nameController,
                  ),
                ),
                spaceAfterEveryField,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Address",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                spaceBtwHeadnField,
                Padding(
                  padding: k,
                  child: UpdateProfileField(
                    currentNode: cityFocusNode,
                    focusNode: cityFocusNode,
                    nextNode: phoneFocusNode,
                    hint_text: user!.address,
                    controller: _cityController,
                  ),
                ),
                spaceAfterEveryField,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "phone",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                spaceBtwHeadnField,
                Padding(
                  padding: k,
                  child: UpdateProfileField(
                    currentNode: phoneFocusNode,
                    focusNode: phoneFocusNode,
                    nextNode: phoneFocusNode,
                    hint_text: user!.phone!,
                    controller: _phoneController,
                  ),
                ),
                SizedBox(
                  height: 46.h,
                ),
                Center(
                    child: isLoadingNow
                        ? const CircleProgress()
                        : AuthButton(
                            height: 56.h,
                            widht: 300.w,
                            func: () async {
                              utils.checkConnectivity(context);
                              isLoading(true);
                              await updateData();
                              await _getUserDetails(utils.currentUserUid);
                              isLoading(false);
                            },
                            text: 'Save Changes',
                            color: Styling.primaryColor,
                          )),
              ],
            ),
          )),
    );
  }

  Widget UploadUpdateSellerProfile(Uint8List? image) {
    return image == null
        ? Stack(
            children: [
              // UpdateSellerProfilePic(url: url, height: height, width: width)
              ProfilePic(url: user!.profileImage, height: 80.h, width: 94.w),

              Positioned(
                left: 45.w,
                bottom: 0.h,
                child: IconButton(
                  onPressed: () async {
                    Uint8List? _image = await utils.pickImage();
                    if (_image != null) {
                      setState(() {
                        _UpdateSellerProfileImage = _image;
                      });
                    } else {
                      debugPrint("Image not loaded");
                    }
                  },
                  icon: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Styling.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset('assets/gallery.png'),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              // ProfilePic(url:image, height: 80.h, width: 94.w),

              ClipOval(
                child: Image.memory(
                  image,
                  height: 80.h,
                  width: 94.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 45.w,
                bottom: 0.h,
                child: IconButton(
                  onPressed: () async {
                    Uint8List? _image = await utils.pickImage();
                    if (_image != null) {
                      setState(() {
                        image = _image;
                      });
                    } else {
                      debugPrint("Image not loaded");
                    }
                  },
                  icon: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Styling.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset('assets/gallery.png'),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 45, left: 50),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 25.w,
            ),
            Text(
              "Update UpdateSellerProfile",
              style: CustomTextStyle.font_18_primary,
            ),
          ],
        ));
  }
}
