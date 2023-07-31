
import 'package:flutter/material.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../style/images.dart';
import '../../style/styling.dart';
import 'home_headers_decoration.dart';

class PreviousParkingWidget extends StatelessWidget {
  const PreviousParkingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: 227.w,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.all(12.w),
        decoration: homeHeadersDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bypass, Hyderabad",
                  style: CustomTextStyle.font_12_grey,
                ),
                Text(
                  "60 pkr",
                  style: CustomTextStyle.font_18_primary,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Abdullah Mall",
              style: CustomTextStyle.font_18_black,
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                SvgPicture.asset(Images.spot),
                Text(
                  "Spot no. 17",
                  style: CustomTextStyle.font_12_grey,
                ),
                SizedBox(
                  width: 60.w,
                  // height: 8.h,
                ),
                const Icon(
                  Icons.hourglass_bottom,
                  color: Styling.primaryColor,
                ),
                Text(
                  "1 hr",
                  style: CustomTextStyle.font_12_grey,
                ),
              ],
            )
          ],
        ));
  }
}
