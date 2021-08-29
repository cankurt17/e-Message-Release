import 'package:flutter/material.dart';
import 'package:online_chat/ui/size_config.dart';

class LocationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ 
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/coming-soon.png"),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "Çok yakında sizlerle..",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(23)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Positioned buildBottomLeft() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Image.asset("assets/images/main_bottom.png"),
      width: SizeConfig.screenWidth * 0.3,
    );
  }

  Positioned buildBottomRight() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Image.asset("assets/images/login_bottom.png"),
      width: SizeConfig.screenWidth * 0.3,
    );
  }

  Positioned buildTopLeft() {
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset("assets/images/signup_top.png"),
      width: SizeConfig.screenWidth * 0.4,
    );
  }
}
