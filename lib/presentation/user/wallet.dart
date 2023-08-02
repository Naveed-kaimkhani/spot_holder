import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/widget/custom_divider.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/style/custom_text_style.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              height: 94.h,
              barTitle: "Wallet",
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 130.w),
              child: Text(
                "Current Balance",
                style: CustomTextStyle.font_12_grey,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 130.w),
              child: Text(
                "260.00 PKR",
                style: CustomTextStyle.font_20,
              ),
            ),
            SizedBox(
              height: 41.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                "Recent Transaction",
                style: CustomTextStyle.font_12_grey,
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            CustomDivider(),
          ],
        ),
      ),
    ));
  }
}
