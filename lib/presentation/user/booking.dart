import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/widget/app_bar.dart';
import 'package:spot_holder/presentation/widget/custom_app_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import '../../style/styling.dart';
import '../widget/decor.dart';

class Booking extends StatelessWidget {
  Booking({super.key});
  final List<Widget> listOfPlans = [
    const PlansWidget(
      time: '1hr - 2hrs:  ',
      price: '30 PKR',
    ),
    const PlansWidget(
      time: '3hr - 4hrs:  ',
      price: '50 PKR',
    ),
    const PlansWidget(
      time: '1hr - 2hrs:  ',
      price: '30 PKR',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const custom_appbar(title: "check out",),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Styling.primaryColor,
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: Container(
                  decoration: auth_screens_decor(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Parking Area",
                            style: CustomTextStyle.font_18_primary,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "Restaurant, Paratha 09",
                            style: CustomTextStyle.font_12_grey,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Row(
                            children: [
                              const CarIcon(
                                icon: Icons.car_repair,
                                text: "Car sports",
                              ),
                              SizedBox(
                                width: 27.w,
                              ),
                              const CarIcon(
                                icon: Icons.location_on_outlined,
                                text: "2 km",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "You can change the duration of booking by selecting any one of the options below",
                            style: CustomTextStyle.font_12_grey,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            "Date",
                            style: CustomTextStyle.font_12_primary,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DateTimeWidget(
                                icon: Icons.calendar_month_outlined,
                                text: "6 Febuary, Monday",
                                widht: 180.w,
                              ),
                              DateTimeWidget(
                                icon: Icons.timer,
                                text: "1:30 pm",
                                widht: 120.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          Text(
                            "Plans",
                            style: CustomTextStyle.font_12_primary,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listOfPlans.length,
                                itemBuilder: (context, index) {
                                  return listOfPlans[index];
                                }),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.all(12.w),
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: Styling.backgroundColor,
                                borderRadius: BorderRadius.circular(16.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  "28 slot Available",
                                  style: CustomTextStyle.font_12_primary,
                                ),
                                Container(
                                  height: 55.h,
                                  width: 170.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(210, 230, 134,
                                            8), // Start color (primaryColor)
                                        Color.fromARGB(255, 220, 172,
                                            58), // End color (you can change this to any other color you want)
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text.rich(TextSpan(
                                        text: "Reserve for  ",
                                        style: CustomTextStyle.font_14,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: "60 PKR ",
                                            style: CustomTextStyle.font_18,
                                          ),
                                          TextSpan(
                                            text:
                                                "\n                       3hr - 4hrs",
                                            style: CustomTextStyle.font_14,
                                          )
                                        ])),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlansWidget extends StatelessWidget {
  final String time;
  final String price;
  const PlansWidget({
    required this.price,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      margin: EdgeInsets.only(right: 14.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color (grey color in this case)
          width: 1.0, // Border width (you can adjust this as needed)
        ),
        borderRadius: BorderRadius.circular(
            25.0), // Circular radius of 25.0 (adjust as needed)
      ),
      child: Center(
        child: Text.rich(TextSpan(
            text: time,
            style: CustomTextStyle.font_12_grey,
            children: <InlineSpan>[
              TextSpan(
                text: price,
                style: CustomTextStyle.font_18_grey,
              )
            ])),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double widht;

  const DateTimeWidget({
    required this.icon,
    required this.text,
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: widht,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color (grey color in this case)
          width: 1.0, // Border width (you can adjust this as needed)
        ),
        borderRadius: BorderRadius.circular(
            25.0), // Circular radius of 25.0 (adjust as needed)
      ),
      // Add your child widget (e.g., TextFormField or TextField) here
      child: Row(
        children: [
          Icon(
            icon,
            color: Styling.primaryColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            text,
            style: CustomTextStyle.font_12_primary,
          )
        ],
      ),
    );
  }
}

class CarIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  const CarIcon({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25.h,
          width: 25.w,
          decoration: BoxDecoration(
            color: Styling.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 20.w,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 9.w,
        ),
        Text(
          text,
          style: CustomTextStyle.font_12_grey,
        )
      ],
    );
  }
}
