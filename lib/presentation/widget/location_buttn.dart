import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/styling.dart';

class Locationbttn extends StatelessWidget {
 final Function func;
 const Locationbttn({super.key,required this.func});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 110.w),
      child: FloatingActionButton(
        backgroundColor: Styling.primaryColor,
        heroTag: "btn2",
        child: const Icon(
          Icons.location_searching_outlined,
          color: Colors.white,
        ),
        onPressed:()async{
          func;
        },
      ),
    );;
  }
}