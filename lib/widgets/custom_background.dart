import 'package:flutter/material.dart';
import 'package:online_chat/animation/fade_animation.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class CustomBackground extends StatelessWidget {
  final title;

  const CustomBackground({Key key, this.title: ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(400),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill),
      ),
      child: Stack(
        children: [
          Positioned(
            left: getProportionateScreenWidth(30),
            width: getProportionateScreenWidth(80),
            height: getProportionateScreenHeight(200),
            child: FadeAnimation(
              1,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(130),
            width: getProportionateScreenWidth(80),
            height: getProportionateScreenHeight(150),
            child: FadeAnimation(
              1.3,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-2.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: getProportionateScreenWidth(40),
            width: getProportionateScreenWidth(80),
            height: getProportionateScreenHeight(200),
            child: FadeAnimation(
              1.5,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clock.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: FadeAnimation(
              2,
              Container(
                child: Center(
                    child: Text(
                  title,
                  style: kTitleTextStyle,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
