import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

import '../../style/styling.dart';

class NoInternetCnnection extends StatefulWidget {
  const NoInternetCnnection({Key? key}) : super(key: key);

  @override
  _NoInternetCnnectionState createState() => _NoInternetCnnectionState();
}

class _NoInternetCnnectionState extends State<NoInternetCnnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                "assets/no.json",
                height: 300.h,
                width: 300.w,
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            Text(
              "Ooops!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 29.sp,
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            const Text(
              "You are not connected to the internet\nPlease check your internet connection",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 42.h,
            ),
            InkWell(
              onTap: () {
                InternetConnectionChecker().hasConnection.then((connected) {
                  if (connected) {
                    Navigator.pop(context);
                    // Do something when connected
                  }
                });
              },
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: Styling.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    "Try Again",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
