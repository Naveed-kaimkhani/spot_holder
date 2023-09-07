import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spot_holder/Domain/models/parking_model.dart';
import 'package:spot_holder/presentation/widget/circle_progress.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/previous_parking_widget.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/utils/routes/routes.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';

import '../../Data/FirebaseUserRepository.dart';
import '../../main.dart';
import '../../style/images.dart';
import '../no_data_found.dart';
import '../widget/home_headers_decoration.dart';
import '../widget/reserved_parking_header.dart';
import '../widget/your_parking_space_widget.dart';

class SellerHomepage extends StatelessWidget {
  const SellerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Styling.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        child: Container(
          height: 54.h,
          width: 176.w,
          decoration: BoxDecoration(
              // color: Styling.backgroundColor
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(
                      210, 230, 134, 8), // Start color (primaryColor)
                  Color.fromARGB(255, 220, 172,
                      58), // End color (you can change this to any other color you want)
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(16.r)),
          child: Center(
              child: Text(
            "Add a New Parking",
            style: CustomTextStyle.font_18,
          )),
        ),
        onTap: () {
          Navigator.pushNamed(context, RoutesName.addNewParking);
        },
      ),
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
                "Your parking space",
                style: CustomTextStyle.font_18_primary,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            
            StreamBuilder<List<ParkingModel>>(
              stream: FirebaseUserRepository.getParkingList(context,false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircleProgress();
                  // return SizedBox();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoDataFoundScreen(
                    text: "No Donation",
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return YourParkingSpaceWidget(
                            parking: snapshot.data![index]);
                      });
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
