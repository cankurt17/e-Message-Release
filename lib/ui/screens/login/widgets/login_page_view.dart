import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/screens/login/widgets/email_login_form.dart';
import 'package:online_chat/ui/screens/login/widgets/phone_login_form.dart';
import 'package:online_chat/ui/screens/login/widgets/validate_login_form.dart';
import 'package:online_chat/ui/size_config.dart';

class LoginPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return Expanded(
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(250),
        child: PageView(
          controller: Get.find<LoginController>().pageViewController,
          physics: new NeverScrollableScrollPhysics(),
          children: [
            EmailLoginForm(),
            PhoneLoginForm(),
            ValidateLoginForm(),
          ],
        ),
      ),
    );
  }
}
