import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_chat/ui/constants.dart';

showLoading() {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: Container(
        child: SpinKitChasingDots(
          color: kPrimaryColor,
          size: 50.0,
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

dismissLoading() {
  Get.back();
}
