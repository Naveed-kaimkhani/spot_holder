import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/user/user_navigation.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../Domain/models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../style/styling.dart';
import '../widget/auth_button.dart';
import '../widget/circle_progress.dart';
import '../widget/input_field.dart';
import '../widget/profile_pic.dart';
import 'package:provider/provider.dart';

class PasswordOption extends StatefulWidget {
  const PasswordOption({Key? key}) : super(key: key);

  @override
  State<PasswordOption> createState() => _PasswordOptionState();
}

class _PasswordOptionState extends State<PasswordOption> {
  TextEditingController _passController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  bool _obsecureText = true;
  bool _obsecureText1 = true;
  bool isLoading = false;
  FocusNode passwordFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;

  void _validateFields() {
    if (_passController.text.trim().isEmpty &&
        _newPasswordController.text.trim().isEmpty) {
      utils.flushBarErrorMessage("please Enter your Password fields", context);
    } else if (_passController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Please Enter Current password', context);
    } else if (_newPasswordController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Please Enter New Password', context);
    } else {
      _changePassword();
    }
  }

  void isLoadingg(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void _changePassword() async {
    User? user = utils.getCurrentUser();
    try {
      isLoadingg(true);
      final userr = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: user!.email!, password: _passController.text))
          .user;
      user
          .reauthenticateWithCredential(EmailAuthProvider.credential(
              email: user.email.toString(),
              password: _passController.text.toString()))
          .then((value) {
        user.updatePassword(_newPasswordController.text).then((value) {
          isLoadingg(false);
          utils.toastMessage("Password updated Successfully");

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const UserNavigation()));
        }).onError((error, stackTrace) {
          isLoadingg(false);
          String errorMessage = utils.getFriendlyErrorMessage(
              error); // Get a user-friendly error message
          utils.flushBarErrorMessage(errorMessage, context); // Handle the erro
        });
      }).onError((error, stackTrace) {
        isLoadingg(false);
        // String errorMessage = utils.getFriendlyErrorMessage(
        //     error); // Get a user-friendly error message

        utils.flushBarErrorMessage(
            error.toString(), context); // Handle the erro
      });
    } catch (e) {
      isLoadingg(false);
      utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  @override
  void dispose() {
    _passController.dispose();
    _newPasswordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Privacy Policy'),
          backgroundColor: Styling.primaryColor,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 27.w, top: 28.h, right: 27.w),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        child: ProfilePic(
                          url: user!.profileImage,
                          height: 60.h,
                          width: 60.w,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name!,
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 14.h,
                  // ),
                  const Divider(
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Current Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  InputField(
                      hint_text: "Current Password",
                      currentNode: null,
                      focusNode: null,
                      nextNode: null,
                      controller: _passController,
                      icon: _obsecureText
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      obsecureText: _obsecureText,
                      onIconPress: () {
                        setState(() {
                          _obsecureText = !_obsecureText;
                        });
                      }),
                  SizedBox(
                    height: 25.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  InputField(
                      hint_text: "New Password",
                      currentNode: null,
                      focusNode: null,
                      nextNode: null,
                      controller: _newPasswordController,
                      icon: _obsecureText1
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      obsecureText: _obsecureText1,
                      onIconPress: () {
                        setState(() {
                          _obsecureText1 = !_obsecureText1;
                        });
                      }),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: isLoading
                        ? const CircleProgress()
                        : AuthButton(
                            height: 46.h,
                            widht: 250.w,
                            text: 'Change Password',
                            color: Styling.primaryColor,
                            func: () async {
                              FocusManager.instance.primaryFocus?.unfocus();

                              _validateFields();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
