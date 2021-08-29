import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/profile_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class AddProfilePhoto extends StatelessWidget {
  ProfileController _controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => _controller.imgFromGallery(),
        child: Container(
          height: getProportionateScreenHeight(35),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
      ),
      width: getProportionateScreenWidth(50),
    );
  }
}
