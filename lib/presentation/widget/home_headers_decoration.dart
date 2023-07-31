import 'package:flutter_screenutil/flutter_screenutil.dart';

  import 'package:flutter/material.dart';

BoxDecoration homeHeadersDecoration() {
    return BoxDecoration(
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
              );
  }
