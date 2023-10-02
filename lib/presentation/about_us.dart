import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/custom_text_style.dart';
import '../style/images.dart';
import '../style/styling.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  SizedBox k = SizedBox(
    height: 20.h,
  );
  SizedBox l = SizedBox(
    height: 10.h,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        title: const Text('About Us'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BackButton(),
          SvgPicture.asset(
            Images.aboutUs,
            // color: Colors.white,
            height: 186.h,
            width: 268.w,
          ),
          l,

          Text(
            "Our Mission",
            style: CustomTextStyle.font_18_primary,
            textAlign: TextAlign.center,
          ),
          l,
          const Text(
            " Our goal is to connect drivers with available parking spaces effortlessly, reducing congestion, and environmental impact, while promoting community sharing and convenience. By facilitating the efficient use of parking resources, we aim to enhance urban mobility, empower property owners, and contribute to a more sustainable, connected, and enjoyable experience for all..",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
