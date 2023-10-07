import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/presentation/widget/app_bar.dart';
import '../../main.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import 'custom_app_bar.dart';

class HomeHeader extends StatelessWidget {
  final String? text;
  final String barTitle;
  // int? balance;
  final double height;
  final String profile;
  HomeHeader({
    Key? key,
    this.text,
   required this.profile,
    // this.balance,
    required this.barTitle,
    // required this.style,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: mq.width,
      padding: EdgeInsets.only(left: 16.w, top: 10.h, right: 16.w),
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
          // CustomAppBar(),
          custom_appbar(
            title: barTitle,
          profile: profile,
          ),
          SizedBox(
            height: 25.h,
          ),
          if (text != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text ?? "",
                style: CustomTextStyle.font_18,
              ),
            ),
        ],
      ),
    );
  }
}
