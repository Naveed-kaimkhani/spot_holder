import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 20,
      thickness: 1,
      endIndent: 20,
      height: 1,
      color: Color.fromARGB(255, 179, 165, 165),
    );
  }
}
