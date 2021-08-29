import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/to_profile_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class ToProfileDetail extends StatelessWidget {
  ToProfileController _controller = ToProfileController();
  @override
  Widget build(BuildContext context) {
    _controller.readUser();
    return Obx(
      () => _controller.toUser != null
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildPhoto(),
                  SizedBox(
                      height:
                          getProportionateScreenHeight(kDefaultPadding / 2)),
                  buildUsername(),
                  SizedBox(
                      height:
                          getProportionateScreenHeight(kDefaultPadding / 4)),
                  buildLastSeen(),
                  SizedBox(
                      height: getProportionateScreenHeight(kDefaultPadding)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildContent(Icons.insert_comment_outlined),
                    ],
                  ),
                ],
              ),
            )
          : CustomProggesIndicator(),
    );
  }

  Text buildUsername() {
    return Text(
      _controller.toUser.userName,
      style: TextStyle(
          color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget buildPhoto() {
    return Hero(
      tag: _controller.toUserID,
      child: CustomLoaderPhoto(
        photoUrl: _controller.toUser.profilUrl,
        height: getProportionateScreenWidth(130),
      ),
    );
  }

  Widget buildLastSeen() {
    return Text(
      "Son görülme " +
          _controller.currentDate(
              _controller.toUser, _controller.toUser.updateAt, DateTime.now()),
      style: TextStyle(color: kIconColor),
    );
  }

  Expanded buildContent(IconData icon) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(width: getProportionateScreenWidth(20)),
                Text(
                  "Gönderiler",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding / 2),
            Container(
              height: 2,
              color: kSecondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
