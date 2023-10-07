import 'package:flutter/material.dart';
import 'package:spot_holder/Domain/models/reserved_parking_model.dart';
import 'package:spot_holder/Domain/models/user_model.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/provider/user_provider.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:provider/provider.dart';
import '../../Data/FirebaseUserRepository.dart';
import '../no_data_found.dart';
import '../widget/circle_progress.dart';
import '../widget/reserved_parking_header.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Styling.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              height: 160.h,
              profile: user!.profileImage!,
              text: "Hi ${user.name}",
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

            StreamBuilder<List<ReservedParkingModel>>(
              stream: FirebaseUserRepository.getReservedParkings(
                  "userUid", context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircleProgress();
                  // return SizedBox();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoDataFoundScreen(
                    text: "No Reserved Parkings",
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ReservedParkingHeader(
                            parking: snapshot.data![index]);
                      });
                }
              },
            ),

            SizedBox(
              height: 22.h,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 16.w, right: 16.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Previous parking",
            //         style: CustomTextStyle.font_18_primary,
            //       ),
            //       const Padding(
            //         padding: EdgeInsets.only(right: 8.0),
            //         child: Text(
            //           "view all",
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // PreviousParkingWidget(),
          ],
        ),
      ),
    ));
  }
}
