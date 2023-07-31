import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../main.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

class HomeHeader extends StatelessWidget {
  // final String? text;
  final double? height;
  // final TextStyle style;
  HomeHeader({
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
      padding: EdgeInsets.only(left: 16.w, top: 20.h),
      decoration: BoxDecoration(
        color: Styling.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                    child: Icon(
                  Icons.menu,
                  color: Styling.primaryColor,
                )),
              ),
              Text(
                "Home",
                style: CustomTextStyle.font_18,
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Hi Qamar",
              style: CustomTextStyle.font_22,
            ),
          ),
        ],
      ),
    );
  }
}
