
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../style/styling.dart';

class CircleProgress extends StatelessWidget {
  const CircleProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitSpinningLines(
      color: Styling.primaryColor,
      size: 50.0,
    );
  }
}
