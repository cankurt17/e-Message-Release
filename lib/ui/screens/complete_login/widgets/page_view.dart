import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/complete_login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/initial_page.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/profile_photo.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/username.dart';

class CopmletePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Center(
        child: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: Get.find<CompleteLoginController>().pageViewController,
          children: [
            Container(),
            InitialPage(),
            ProfilePhoto(),
            Username(),
            Container(),
          ],
        ),
      ),
    );
  }
}
