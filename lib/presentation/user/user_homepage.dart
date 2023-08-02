import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/previous_parking_widget.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import '../../style/images.dart';
import '../widget/home_headers_decoration.dart';
import '../widget/reserved_parking_header.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Styling.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              height: 180.h,
              text: "Hi Qamar",
              barTitle: "Home",
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Reserved parking spaces",
                style: CustomTextStyle.font_18_primary,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const ReservedParkingHeader(),
            SizedBox(
              height: 22.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Previous parking",
                    style: CustomTextStyle.font_18_primary,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      "view all",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            PreviousParkingWidget(),
          ],
        ),
      ),
    ));
  }
}
