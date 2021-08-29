import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/page_view.dart';
import 'package:online_chat/ui/size_config.dart';

class CompleteLoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            buildTopLeft(),
            buildBottomLeft(),
            buildBottomRight(),
            CopmletePageView()
          ],
        ),
      ),
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
