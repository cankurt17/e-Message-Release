import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/profile_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/profile/widget/add_photo.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class ProfileContent extends StatelessWidget {
  ProfileController _controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: getProportionateScreenWidth(130),
              child: Stack(
                children: [
                  buildPhoto(),
                  AddProfilePhoto(),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
            buildUsername(),
          ],
        ),
      ),
    );
  }

  Align buildPhoto() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: getProportionateScreenHeight(150),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipOval(
            child: FadeInImage(
              placeholder: AssetImage("assets/images/loader.gif"),
              image: _controller.profileImg == null
                  ? NetworkImage(_controller.fromUser.profilUrl)
                  : _controller.profileImg,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Text buildUsername() {
    return Text(
      _controller.fromUser.userName,
      style: TextStyle(
          color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
