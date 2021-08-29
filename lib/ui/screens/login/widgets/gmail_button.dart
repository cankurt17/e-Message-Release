import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/size_config.dart';

class GmailButton extends StatelessWidget {
  LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _loginController.signInWithGoogle();
      },
      child: Image.asset(
        "assets/icons/google.png",
        width: getProportionateScreenWidth(55),
      ),
    );
  }
}
