import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/singup_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/widgets/default_button.dart';

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: DefaultButton(
        text: "Kayıt Ol",
        press: () {
          Get.find<SingupController>().createUserWithEmailandPassword();
        },
      ),
    );
  }
}
