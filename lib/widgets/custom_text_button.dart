import 'package:flutter/material.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class CustomTextButton extends StatelessWidget {
  final Function press;
  final String text;

  const CustomTextButton({Key key, this.press, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: getProportionateScreenHeight(26),
        child: Text(
          text,
          style: TextStyle(color: kTextLightColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
