// import 'package:donation_app/data/firebase_user_repository.dart';
// import 'package:donation_app/domain/models/seller_model.dart';
// import 'package:donation_app/presentation/widgets/profile_pic.dart';
// import 'package:donation_app/presentation/widgets/wave_circle.dart';
// import 'package:donation_app/providers/seller_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../domain/models/donation_model.dart';
// import '../../style/custom_text_style.dart';
// import '../widgets/chart_decoration.dart';
// import '../widgets/chart_widget.dart';
// import '../widgets/donation_widget.dart';
// import 'no_data_found.dart';

// class DonarHomePage extends StatefulWidget {
//   DonarHomePage({Key? key}) : super(key: key);

//   @override
//   State<DonarHomePage> createState() => _DonarHomePageState();
// }

// class _DonarHomePageState extends State<DonarHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     SellerModel? donar =
//         Provider.of<SellerProvider>(context, listen: false).seller;

//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder<List<DonationModel>>(
//           stream: FirebaseUserRepository.getDonationList(context),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const WaveCircleProgress();
//             } else if (snapshot.hasError) {
//               return Text(snapshot.error.toString());
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const NoDataFoundScreen(
//                 text: "No Donation",
//               );
//             } else {
//               return SingleChildScrollView(
//                 // Wrap everything in a SingleChildScrollView
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ... your other widgets ...

//                       Text(
//                         'Welcome',
//                         style: CustomTextStyle.font_14_black,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(donar!.name ?? "Hi Donar",
//                               style: CustomTextStyle.font_24_primaryColor),
//                           ProfilePic(
//                               url: donar.profileImage,
//                               height: 44.h,
//                               width: 52.w)
//                         ],
//                       ),
//                       SizedBox(height: 11.h),
//                       Divider(
//                         height: 1,
//                         color: Colors.grey[600],
//                       ),
//                       SizedBox(
//                         height: 12.h,
//                       ),
//                       Text(
//                         'Monthly Donation Analysis',
//                         style: CustomTextStyle.font_24,
//                       ),
//                       SizedBox(
//                         height: 8.h,
//                       ),
//                       Container(
//                         width: 325.w,
//                         height: 158.h,
//                         decoration: chardecoration(),
//                         child: ChartWidget(
//                           chartData: FirebaseUserRepository.getMonthlyDonation(
//                               snapshot.data!),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Divider(
//                         height: 1,
//                         color: Colors.grey[600],
//                       ),
//                       SizedBox(height: 6.h),
//                       Text(
//                         'Successful Donation',
//                         style: CustomTextStyle.font_24,
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context)
//                             .size
//                             .height, // Use a fixed height here
//                         child: ListView.builder(
//                           physics:
//                               NeverScrollableScrollPhysics(), // Disable scrolling
//                           shrinkWrap:
//                               true, // Allow the ListView to take the required height
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             return DonationWidget(
//                                 showButton: false,
//                                 donationModel: snapshot.data![index]);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
