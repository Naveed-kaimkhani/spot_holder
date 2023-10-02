import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/seller/track_user.dart';
import 'package:spot_holder/presentation/widget/time_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../Domain/models/reserved_parking_model.dart';
import '../../Domain/models/user_model.dart';
import '../../main.dart';
import '../../provider/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

class ParkingStatusWidget extends StatelessWidget {
  final ReservedParkingModel parking;
  const ParkingStatusWidget({
    required this.parking,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).seller;
    //  String distance=  utils.getDistancebtwSourceNDestination(user!.lat!, user.long!, parking.locationLat!,parking.locationLong!).toString();

    return Container(
      height: 102.h,
      width: 343.w,
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
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  parking.durationTime!,
                  style: CustomTextStyle.font_12_grey,
                ),
                Text(
                  " ${parking.price.toString()} Pkr",
                  style: CustomTextStyle.font_18_primary,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              parking.userName!,
              style: CustomTextStyle.font_18_black,
            ),
            // SizedBox(
            //   height: 3.h,
            // ),
            Row(
              children: [
                SvgPicture.asset(Images.spot),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Spot no: ${parking.bookedSlots}",
                  style: CustomTextStyle.font_12_grey,
                ),
                SizedBox(
                  width: 164.w,
                ),
                InkWell(
                  child: Icon(
                    Icons.directions,
                    color: Styling.primaryColor,
                    size: 36.h,
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return TrackUser(requestModel: parking);
                    }));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
