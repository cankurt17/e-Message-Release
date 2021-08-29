import 'package:flutter/material.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/login/widgets/email_and_password.dart';
import 'package:online_chat/ui/screens/login/widgets/login_button.dart';
import 'package:online_chat/ui/screens/login/widgets/password_and_singup_button.dart';
import 'package:online_chat/ui/size_config.dart';

class EmailLoginForm extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmailAndPassword(),
        SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
        LoginButton(),
        SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
        PasswordAndSingupButton(),
      ],
    );
  }
}
