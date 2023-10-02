import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/utils/utils.dart';

import '../../style/styling.dart';

class UpdateProfileField extends StatelessWidget {
  String? hint_text;
  FocusNode? currentNode;
  FocusNode? nextNode;
  bool? obsecureText;
  FocusNode? focusNode;
  IconData? icon;
  Widget? preicon;
  dynamic validator;
  TextInputType? keyboardType;
  // bool? visiblity;
  Function()? onIconPress;
  TextEditingController? controller;
  UpdateProfileField({
    super.key,
    required this.hint_text,
    required this.currentNode,
    required this.focusNode,
    required this.nextNode,
    required this.controller,
    this.validator,
    this.icon,
    this.preicon,
    this.onIconPress,
    this.obsecureText,
    this.keyboardType,
    // this.visiblity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextFormField(
        style: const TextStyle(
            color: Colors.black, fontFamily: "Sansita", fontSize: 16),
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obsecureText ?? false,
        controller: controller,
        cursorColor: Colors.black,
        focusNode: focusNode,
        onEditingComplete: () =>
            utils.fieldFocusChange(context, currentNode!, nextNode!),
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: hint_text,
          focusColor: Styling.primaryColor,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 112, 102, 102),
            fontSize: 14.sp,
          ),
          prefixIcon: preicon,
          suffixIcon: InkWell(
            onTap: onIconPress,
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 65, 61, 61),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}