import 'package:flutter/material.dart';
import 'package:spot_holder/Domain/models/parking_model.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/utils/utils.dart';

import '../../style/images.dart';
import '../../style/styling.dart';
import 'home_headers_decoration.dart';

class PreviousParkingWidget extends StatelessWidget {
  final ParkingModel parking;
  const PreviousParkingWidget({
    super.key,
    required this.parking,
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
                  utils.trimAddressToHalf(parking.parkingAddress!),
                  style: CustomTextStyle.font_12_grey,
                ),
                Text(
                  "${parking.price} pkr",
                  style: CustomTextStyle.font_18_primary,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              utils.trimAddressToHalf(parking.parkingAddress!),
              style: CustomTextStyle.font_18_black,
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                SvgPicture.asset(Images.spot),
                Text(
                  " Spots ${parking.availableSlots}",
                  style: CustomTextStyle.font_10_primary,
                ),
                SizedBox(
                  width: 82.w,
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
