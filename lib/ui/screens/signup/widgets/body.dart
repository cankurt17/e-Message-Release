import 'package:flutter/material.dart';
import 'package:online_chat/animation/fade_animation.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/signup/widgets/login_button.dart';
import 'package:online_chat/ui/screens/signup/widgets/signup_button.dart';
import 'package:online_chat/ui/screens/signup/widgets/signup_form.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_background.dart';

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadeAnimation(
        1,
        Column(
          children: [
            CustomBackground(title: "Kayıt Ol"),
            SignupForm(),
            SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
            SignupLoginButton(),
            SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
            SignupButton(),
            SizedBox(height: getProportionateScreenHeight(kDefaultPadding)),
          ],
        ),
      ),
    );
  }
}
