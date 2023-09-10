import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/time_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/style/styling.dart';

import '../../Domain/models/parking_model.dart';
import '../../main.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';

class YourParkingSpaceWidget extends StatelessWidget {
  final ParkingModel parking;
  const YourParkingSpaceWidget({
    required this.parking,
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
              parking.parkingAddress!,
              style: CustomTextStyle.font_14_black,
            ),
            SizedBox(
              height: 20.h,
            ),
            spots(
              text: "Total Slots",
              slots: parking.availableSlots!,
            ),
            SizedBox(
              height: 10.h,
            ),
            spots(
              text: "Booked Slots",
              slots: parking.bookedSlots!,
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parking.sentTime.toString(),
                      style: CustomTextStyle.font_12_grey,
                    ),
                    Text(
                      parking.sentDate.toString(),
                      style: CustomTextStyle.font_12_grey,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "  ${parking.price} pkr",
                      style: CustomTextStyle.font_18_primary,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 12.0, top: 4),
                    //   child: Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.hourglass_bottom,
                    //         color: Styling.primaryColor,
                    //       ),
                    //       Text(
                    //         "",
                    //         style: CustomTextStyle.font_12_grey,
                    //       )
                    //       // Image.asset(Images.)
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class spots extends StatelessWidget {
  final String text;
  final int slots;
  const spots({
    required this.slots,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Images.spot),
        SizedBox(
          width: 4.h,
        ),
        Text(
          "$text: $slots",
          style: CustomTextStyle.font_12_grey,
        )
      ],
    );
  }
}
