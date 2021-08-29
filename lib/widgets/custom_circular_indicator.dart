import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_chat/ui/constants.dart';

class CustomProggesIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: kPrimaryColor,
        size: 50.0,
      ),
    );
  }
}
