import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:spot_holder/utils/utils.dart';

class InputField extends StatelessWidget {
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
  InputField({
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(12.w),
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
          fillColor: Styling.textfieldsColor,
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          border: InputBorder.none,
          hintText: hint_text,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 112, 102, 102),
            fontSize: 17.sp,
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
