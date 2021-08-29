import 'package:flutter/material.dart';
import 'package:online_chat/animation/fade_animation.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/login/widgets/background.dart';
import 'package:online_chat/ui/screens/login/widgets/email_and_password.dart';
import 'package:online_chat/ui/screens/login/widgets/login_button.dart';
import 'package:online_chat/ui/screens/login/widgets/login_page_view.dart';
import 'package:online_chat/ui/screens/login/widgets/password_and_singup_button.dart';
import 'package:online_chat/ui/screens/login/widgets/social_media.dart';
import 'package:online_chat/ui/size_config.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1,
      SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Backgraund(),
              LoginPageView(),
              SocialMediaButton(),
            ],
          ),
        ),
      ),
    );
  }
}
