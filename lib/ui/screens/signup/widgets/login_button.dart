import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/singup_controller.dart';
import 'package:online_chat/widgets/custom_text_button.dart';

class SignupLoginButton extends StatelessWidget {
  const SignupLoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: "Zaten hesabın var mı? Giriş yap.",
      press: () {
        Get.find<SingupController>().currentUser();
        Get.back();
      },
    );
  }
}
