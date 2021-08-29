import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/splash_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class Splash extends StatelessWidget {
  SplashController _controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kSecondaryColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: getProportionateScreenWidth(100),
                height: getProportionateScreenHeight(100),
                child:
                    Image.asset("assets/icons/appIcon.png", fit: BoxFit.contain),
              ),
              Spacer(),
              Padding(
                padding:
                    EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
                child: Text(
                  "Beta sürüm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontSize: getProportionateScreenHeight(22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
