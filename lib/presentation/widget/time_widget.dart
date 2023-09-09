import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/custom_text_style.dart';

class TimeWidget extends StatelessWidget {
  final String time;
  final String date;
  final int? charges;

  const TimeWidget({
    this.charges,
    required this.date,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: CustomTextStyle.font_18_black,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          date,
          style: CustomTextStyle.font_12_grey,
        ),
        SizedBox(
          height: 12.h,
        ),
        if (charges != null)
          Text(
            "${charges.toString()} PKR",
            style: CustomTextStyle.font_18_primary,
          ),
      ],
    );
  }
}
