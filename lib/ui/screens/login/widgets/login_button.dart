import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/widgets/default_button.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(kDefaultPadding),
      ),
      child: DefaultButton(
        text: "Giriş Yap",
        press: () {
          Get.find<LoginController>().signInWithEmailandPassword();
        },
      ),
    );
  }
}
