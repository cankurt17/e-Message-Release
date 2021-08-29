import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/size_config.dart';

class FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<LoginController>().signInWithFacebook();
      },
      child: Image.asset(
        "assets/icons/facebook.png",
        width: getProportionateScreenWidth(55),
      ),
    );
  }
}
