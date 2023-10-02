import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spot_holder/Data/FirebaseUserRepository.dart';
import 'package:spot_holder/presentation/seller/seller_navigation.dart';
import 'package:spot_holder/presentation/user/user_navigation.dart';
import 'package:spot_holder/provider/user_provider.dart';
import 'package:spot_holder/style/storage_services.dart';
import 'package:spot_holder/user_or_seller.dart';
import 'package:spot_holder/utils/utils.dart';
import '../style/images.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  // NotificationServices _notificationServices =NotificationServices();
  @override
  void initState() {
    // _notificationServices.requestNotificationPermission();
    // _notificationServices.firebaseInit(context);
    // _notificationServices.isTokenRefresh();
    // _notificationServices.setupInteractMessage(context);
    // _notificationServices.getDeviceToken().then((value) {
    // })
    utils.checkConnectivity(context);
    
    Timer(const Duration(seconds: 2), () {
    loadData();
  });
  super.initState();
  }

  loadData() async {
    User? user=utils.getCurrentUser();
    int? isUser= await StorageService.checkUserInitialization();

    try {
if (user!=null ) {
  if (isUser==1 && isUser!=null) {

        await _firebaseUserRepository.loadUserDataOnAppInit(context);
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserNavigation()),
      );
  }else{
            await Provider.of<UserProvider>(context, listen: false)
            .getSellerFromServer(context);

    // await _firebaseUserRepository.loadSellerDataOnAppInit(context);
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SellerNavigation()),
      );
  }
} else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserSellerScreen()),
      );
}
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      // Handle error if any
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250.w,
            ),
            Image.asset(
              Images.logo,
              height: 180.h,
              width: 180.w,
            ),
            SizedBox(
              height: 230.h,
            ),
            const Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SpinKitSpinningLines(
                color: Colors.black,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}