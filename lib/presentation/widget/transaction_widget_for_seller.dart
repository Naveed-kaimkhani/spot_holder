import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/style/custom_text_style.dart';

import '../../Domain/transaction.dart';
import '../../main.dart';

class TransactionHistoryWidgetForSeller extends StatelessWidget {
  final TransactionModel model;
  const TransactionHistoryWidgetForSeller({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: mq.width,
      padding: EdgeInsets.all(8.w),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Money Received",
                  style: CustomTextStyle.font_12_grey,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "sender: ${model.senderName}",
                  style: CustomTextStyle.font_14_black,
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.transactionTime!,
                  style: CustomTextStyle.font_8_grey,
                ),
                Text(
                  model.transactionDate!,
                  style: CustomTextStyle.font_8_grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "${model.payment} Pkr",
                  style: TextStyle(fontSize: 18.sp, color: Colors.green),
                ),
              ],
            ),
            leading: Icon(
              Icons.history_sharp,
              size: 24.h,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 260.0),
          //   child: Column(
          //     children: [
          //       Text(model.transactionTime!),
          //       Text(model.transactionDate!),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
