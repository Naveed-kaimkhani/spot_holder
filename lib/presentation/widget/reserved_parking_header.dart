
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/time_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';

class ReservedParkingHeader extends StatelessWidget {
  const ReservedParkingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: mq.width,
      // padding: EdgeInsets.all(32.w),
      margin: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Paratha 09, Naseem Nagar",
              style: CustomTextStyle.font_14_black,
            ),
            Row(
              children: [
                Text(
                  "On Spot Parking",
                  style: CustomTextStyle.font_12_grey,
                ),
                SizedBox(
                  width: 20.w,
                ),
                SvgPicture.asset(Images.pointer),
                Text(
                  "700m",
                  style: CustomTextStyle.font_12_grey,
                ),
              ],
            ),
            SizedBox(
              height: 23.h,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeWidget(
                  time: "1:30 PM",
                  date: "6 Feb, 2023",
                ),
                TimeWidget(
                  time: "1:30 PM",
                  date: "6 Feb, 2023",
                  charges: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
