import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoDataFoundScreen extends StatelessWidget {
  final String text;
  const NoDataFoundScreen({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/no_data.json", height: 350.h, width: 350.w),
          Text(text)
        ],
      ),
    );
  }
}
