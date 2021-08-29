import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CustomPinput extends StatelessWidget {
  LoginController controller = Get.find();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: PinPut(
          fieldsCount: 6,
          withCursor: true,
          textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
          eachFieldWidth: getProportionateScreenWidth(50),
          eachFieldHeight: getProportionateScreenHeight(55),
          onSubmit: (String pin) => print(pin),
          focusNode: controller.pinPutFocusNode,
          controller: controller.pinPutController,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: pinPutDecoration,
          followingFieldDecoration: pinPutDecoration,
          pinAnimationType: PinAnimationType.fade,
        ),
      ),
    );
  }
}
