import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/profile_pic.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../../style/custom_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Domain/models/parking_model.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import 'call_widget.dart';

class ParkingInfoWindow extends StatefulWidget {
  ParkingModel parking;

  ParkingInfoWindow({super.key, required this.parking});

  @override
  State<ParkingInfoWindow> createState() => _ParkingInfoWindowState();
}

class _ParkingInfoWindowState extends State<ParkingInfoWindow> {
  bool isRequestSend = false;

  @override
  Widget build(BuildContext context) {
    int midIndex = widget.parking.parkingAddress!.length ~/
        2; // Calculate the middle index

    String address = widget.parking.parkingAddress!.substring(0, midIndex);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        // padding: EdgeInsets.all(20),
        height: 150.h,
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Styling.primaryColor),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, top: 4.h),
                      child: ProfilePic(
                        height: 35.h,
                        width: 42.w,
                        url: widget.parking.pictures![0],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // widget.requestModel!.senderName!,
                          utils.trimAddressToHalf(
                                  widget.parking.parkingAddress!) ??
                              "No Sender Name",
                          style: CustomTextStyle.font_20,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Styling.primaryColor,
                              size: 12.h,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              // widget.parking.workshopName!,
                              address,
                              style: CustomTextStyle.font_14_black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // CallWidget(num: widget.parking.phone!, context: context),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available spots",
                          style: CustomTextStyle.font_14_black,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Images.spot),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              widget.parking.availableSlots.toString(),
                              style: CustomTextStyle.font_14_black,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SendRequestBttnForSpecificparking(
                    //   parking: widget.parking,
                    //   height: 30.h,
                    //   widht: 95.w,
                    //   textSize: 13.sp,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: 
                      CallWidget(
                        num: widget.parking.ownerPhone!,
                        context: context,
                        radius: 20.r,
                        iconSize: 16.h,
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
