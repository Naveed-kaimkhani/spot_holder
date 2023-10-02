import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_holder/style/styling.dart';

import '../style/images.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);
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
        title: const Text('Contact Us'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BackButton(),
          SvgPicture.asset(
            Images.contactUs,
            // color: Colors.white,
            height: 186.h,
            width: 268.w,
            // color: Styling.primaryColor,
          ),
          k,
          const Icon(
            Icons.location_on_outlined,
            color: Styling.primaryColor,
          ),
          l,
          const Text(
            "Our Office Located near the Mehran University of Engineering and Technology,\n and Society, Jamshoro ",
            textAlign: TextAlign.center,
          ),
          k,
          const Icon(
            Icons.phone,
            color: Styling.primaryColor,
          ),
          l,
          const Center(
            child: Text(
              "03368512814",
              textAlign: TextAlign.center,
            ),
          ),
          k,
          const Icon(
            Icons.mail,
            color: Styling.primaryColor,
          ),
          l,
          const Text(
            "SpotHolder.CUSTOMERCARE@GMAIL.COM",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
