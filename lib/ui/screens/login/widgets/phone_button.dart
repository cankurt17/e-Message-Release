import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/size_config.dart';

class PhoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          Get.find<LoginController>().changePageView(enumPageView.emailForm);
        },
        child: Image.asset(
          Get.find<LoginController>().pageViewIndex == 0
              ? "assets/icons/phone.png"
              : "assets/icons/email.png",
          width: getProportionateScreenWidth(55),
        ),
      ),
    );
  }
}
