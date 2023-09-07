import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../Domain/models/parking_model.dart';
import '../../presentation/widget/button_for_dialogue.dart';
import '../../style/images.dart';

parkingDonePopup(context,String text) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              Images.done,
              height: 120.h,
              width: 120.w,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xff326060),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'You have successfully added a new parking.\n Thank you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: ButtonForDialogue(
                    text: "Ok",
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 14.w,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
