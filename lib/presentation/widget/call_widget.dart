
import 'package:flutter/material.dart';
import 'package:spot_holder/utils/utils.dart';

import '../../../style/styling.dart';

class CallWidget extends StatelessWidget {
final  String num;
 final double radius;

 final double iconSize;
 final BuildContext context;
 const CallWidget({
    required this.iconSize,
    required this.radius,
    required this.num,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        backgroundColor: Styling.primaryColor,
        radius: radius,
        child: Icon(
          Icons.call,
          color: Colors.white,
          size: iconSize,
        ),
      ),
      onTap: () {
      
        utils.launchphone(num, context);
      },
    );
  }
}
