import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  final String? text;
  final Function()? func;
  final Color? color;
  const AuthButton({
    required this.text,
    required this.func,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        width: 277.w,
        height: 50.h,
        decoration: BoxDecoration(
          // color: color,
          gradient: const LinearGradient(
            colors: [
              Color(0xff662D91), // Start color (primaryColor)
              Color.fromARGB(255, 162, 148,
                  232), // End color (you can change this to any other color you want)
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
