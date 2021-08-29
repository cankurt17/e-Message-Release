import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/complete_login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/add_photo.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/custom_pageview_button.dart';
import 'package:online_chat/ui/size_config.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: getProportionateScreenWidth(150),
            child: Stack(
              children: [
                buildPhoto(),
                AddPhoto(),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding * 2)),
          Text(
            "Profil resminiz insanların sizi daha iyi tanımalarına yardımcı olur.",
            style: kContentBodyTextStyle,
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding * 2)),
          CustomPageViewButton()
        ],
      ),
    );
  }
}

Align buildPhoto() {
  return Align(
    alignment: Alignment.center,
    child: Container(
      height: getProportionateScreenHeight(150),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipOval(
          child: FadeInImage(
            placeholder: AssetImage("assets/images/loader.gif"),
            image: Get.find<CompleteLoginController>().profileImg == null
                ? NetworkImage(
                    Get.find<CompleteLoginController>().user.profilUrl)
                : Get.find<CompleteLoginController>().profileImg,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}
