import 'package:flutter/material.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;

  const CustomSuffixIcon({Key key, this.iconData, this.color: kTextLightColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, getProportionateScreenWidth(14),
          getProportionateScreenWidth(14), getProportionateScreenWidth(14)),
      child: Icon(
        iconData,
        color: color,
        size: getProportionateScreenWidth(20),
      ),
    );
  }
}
