import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/styling.dart';

class ButtonForDialogue extends StatelessWidget {
  String text;
  ButtonForDialogue({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: Styling.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
