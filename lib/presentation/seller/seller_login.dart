import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/seller/seller_navigation.dart';
import 'package:spot_holder/presentation/widget/auth_button.dart';
import 'package:spot_holder/presentation/widget/circle_progress.dart';
import 'package:spot_holder/style/images.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';
import 'package:spot_holder/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../style/styling.dart';
import '../../Data/FirebaseUserRepository.dart';
import '../../provider/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../widget/auth_header.dart';
import '../widget/custom_divider.dart';
import '../widget/input_field.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({Key? key}) : super(key: key);

  @override
  State<SellerLogin> createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  final FirebaseUserRepository _firebaseRepository = FirebaseUserRepository();
  final _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? obsecureText = true;
  bool isLoadingNow = false;
  bool _obsecureText = true;
  Widget k = SizedBox(
    height: 16.h,
  );

  void isLoading(bool value) {
    setState(() {
      isLoadingNow = value;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  void _login() {
    isLoading(true);
    _firebaseRepository
        .login(_emailController.text, _passwordController.text, context)
        // .login("seller@gmail.com", "111111", context)
        .then((User? user) async {
      if (user != null) {
        //  final   currentLocation = await Geolocator.getCurrentPosition();
        _getUserDetails();
      } else {
        isLoading(false);
        utils.flushBarErrorMessage("Failed to login", context);
      }
    });
  }

  void _getUserDetails() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getSellerFromServer(context);
    isLoading(false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SellerNavigation()));
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    utils.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthHeader(
                    height: 260.h,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Image.asset(
                    Images.logo,
                    width: 241.w,
                    height: 45.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    hint_text: "Email",
                    currentNode: emailFocusNode,
                    focusNode: emailFocusNode,
                    nextNode: passwordFocusNode,
                    controller: _emailController,
                    obsecureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter email address";
                      } else if (!EmailValidator.validate(value)) {
                        return "Invalid email address";
                      }
                    },
                  ),
                  // k,
                  InputField(
                    hint_text: "Password",
                    currentNode: passwordFocusNode,
                    focusNode: passwordFocusNode,
                    nextNode: passwordFocusNode,
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    icon: obsecureText!
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                    obsecureText: obsecureText,
                    onIconPress: () {
                      setState(() {
                        obsecureText = !obsecureText!;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter password";
                      } else if (value.length < 6) {
                        return "password must be of 6 characters";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 230.w),
                    child: TextButton(
                        onPressed: () {}, child: const Text("Forget Password")),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Center(
                    child: isLoadingNow
                        ? const CircleProgress()
                        : AuthButton(
                            height: 56.h,
                            widht: 300.w,
                            text: "Login",
                            func: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              _submitForm();
                              // _login();
                            },
                            color: Styling.primaryColor),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),

                  CustomDivider(),
                  // Row(
                  //   children: [
                  //     Text("or"),
                  //     CustomDivider(),
                  //   ],
                  // ),

                  SizedBox(
                    height: 8.h,
                  ),
                  AuthButton(
                    height: 56.h,
                    widht: 300.w,
                    text: "SignUp",
                    func: () {
                      Navigator.pushNamed(context, RoutesName.sellerSignup);
                    },
                    color: Styling.primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 48.w),
                    child: TextButton(
                      onPressed: () {},
                      child: Text.rich(TextSpan(
                          text: 'Dont have a account? ',
                          style: CustomTextStyle.font_18,
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Create Now',
                              style: CustomTextStyle.font_18,
                            )
                          ])),
                    ),
                  ),
                  // Pa
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
}
