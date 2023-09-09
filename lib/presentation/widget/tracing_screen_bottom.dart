import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../style/styling.dart';
import '../user/user_parking_direction.dart';

class TracingScreenBottomNavigation extends StatelessWidget {
  const TracingScreenBottomNavigation({
    super.key,
    required this.distance,
    required this.halfLength,
    required this.address,
    // required this.widget,
    required this.firstLine,
    // required this.widget,
  });

  final String? distance;
  final double halfLength;
  final double firstLine;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 26.h,
            width: 120.w,
            decoration: BoxDecoration(
                color: Styling.primaryColor,
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: Text(
                distance!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Styling.primaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(address),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            child: Container(
              height: 40.h,
              width: 230.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Styling.primaryColor,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  Text(
                    "Call Owner",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            onTap: () {
              // utils.launchphone(
              //     widget.requestModel.senderPhone!, context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
