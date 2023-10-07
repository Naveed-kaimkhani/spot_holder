import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/time_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:spot_holder/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../Domain/models/reserved_parking_model.dart';
import '../../Domain/models/user_model.dart';
import '../../main.dart';
import '../../provider/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../user/user_parking_direction.dart';

class ReservedParkingHeader extends StatelessWidget {
  final ReservedParkingModel parking;
  const ReservedParkingHeader({
    required this.parking,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
    String distance = utils
        .getDistancebtwSourceNDestination(
            user!.lat!, user.long!, parking.locationLat!, parking.locationLong!)
        .toString();

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
              height: 4.h,
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
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  distance,
                  style: CustomTextStyle.font_12_grey,
                ),
              ],
            ),
            SizedBox(
              height: 23.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reserved Time",
                      style: CustomTextStyle.font_12_primary,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TimeWidget(
                      time: parking.reservedTime!,
                      date: parking.reservedDate!,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.directions,
                        size: 34.h,
                        color: Styling.primaryColor,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserParkingTraking(parkingModel: parking)));
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Parking Plan",
                      style: CustomTextStyle.font_12_primary,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      parking.durationTime!,
                      style: CustomTextStyle.font_18_black,
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Text(
                      "${parking.price} Pkr",
                      style: CustomTextStyle.font_22_primary,
                    ),
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
