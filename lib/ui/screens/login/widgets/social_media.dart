import 'package:flutter/material.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/login/widgets/facebook_button.dart';
import 'package:online_chat/ui/screens/login/widgets/gmail_button.dart';
import 'package:online_chat/ui/screens/login/widgets/phone_button.dart';
import 'package:online_chat/ui/size_config.dart';

class SocialMediaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(120),
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bottom_backgraund.png"),
              fit: BoxFit.fill)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FacebookButton(),
            SizedBox(width: getProportionateScreenWidth(kDefaultPadding)),
            GmailButton(),
            SizedBox(width: getProportionateScreenWidth(kDefaultPadding)),
            PhoneButton(),
          ],
        ),
      ),
    );
  }

  Image buildBackgraund() {
    return Image.asset(
      "assets/images/bottom_backgraund.png",
      fit: BoxFit.fill,
      width: double.infinity,
    );
  }
}
