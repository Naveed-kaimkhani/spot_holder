import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../main.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

class AuthHeader extends StatelessWidget {
  // final String? text;
  final double? height;
  // final TextStyle style;
  AuthHeader({
    Key? key,
    // required this.text,
    // required this.style,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: mq.width,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: Styling.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.car,
            // color: Colors.white,
            height: 136.h,
            width: 218.w,
          ),
          SizedBox(
            height: 7.h,
          ),
          Text(
            "Welcome",
            style: CustomTextStyle.font_18,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            "We welcome you to our app where you can book parking with just few taps.",
            style: CustomTextStyle.font_14,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
