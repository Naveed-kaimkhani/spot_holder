import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/widget/custom_divider.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/provider/user_provider.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:provider/provider.dart';
import '../../Data/FirebaseUserRepository.dart';
import '../../Domain/models/user_model.dart';
import '../../Domain/transaction.dart';
import '../no_data_found.dart';
import '../widget/circle_progress.dart';
import '../widget/transaction_widget.dart';
import '../widget/transaction_widget_for_seller.dart';

class SellerWallet extends StatelessWidget {
  const SellerWallet({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? seller =
        Provider.of<UserProvider>(context, listen: false).seller;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              height: 84.h,
              barTitle: "SellerWallet",
              profile: seller!.profileImage!,
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
                " ${seller!.balance} Pkr",
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
            const CustomDivider(),
            StreamBuilder<List<TransactionModel>>(
              stream: FirebaseUserRepository.getTransactionHistoryForSeller(
                  context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircleProgress());
                  // return SizedBox();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoDataFoundScreen(
                    text: "No Recent Transactions",
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return TransactionHistoryWidgetForSeller(
                            model: snapshot.data![index]);
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
