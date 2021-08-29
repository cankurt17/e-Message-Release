import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MediaBottomSheet extends StatelessWidget {
  MediaBottomSheet({
    Key key,
  }) : super(key: key);

  ChatController _controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Obx(
        () => _controller.imageFile == null ? selectMedia() : showMedia(),
      ),
    );
  }

  Widget showMedia() {
    return _controller.loadingPhoto != true ? photoSend() : photoLoading();
  }

  Column photoLoading() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: getProportionateScreenHeight(120),
                  lineWidth: getProportionateScreenHeight(15),
                  percent: _controller.progress,
                  animation: true,
                  animationDuration: 500,
                  progressColor: kPrimaryColor,
                  center: Text(
                    ' ${(_controller.progress * 100).toStringAsFixed(0)} %',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  footer: Text(
                    "Yükleniyor...",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenHeight(18),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(50))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column photoSend() {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: getProportionateScreenHeight(150),
            width: double.infinity,
            child: Image(
              image: FileImage(_controller.imageFile),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
        InkWell(
          onTap: () {
            _controller.sendMessage(type: "photo");
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: getProportionateScreenHeight(50),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Gönder",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: kPrimaryColor,
                ),
                SizedBox(width: getProportionateScreenWidth(kDefaultPadding)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Wrap selectMedia() {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildCamera(),
            SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
            buildGallery(),
          ],
        ),
      ],
    );
  }

  InkWell buildCamera() {
    return InkWell(
      onTap: () {
        _controller.connectCamera();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        height: getProportionateScreenHeight(50),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Icon(
              Icons.add_a_photo_outlined,
              color: kPrimaryColor,
            ),
            SizedBox(width: getProportionateScreenWidth(kDefaultPadding)),
            Text("Kamera"),
            Spacer(),
          ],
        ),
      ),
    );
  }

  InkWell buildGallery() {
    return InkWell(
      onTap: () {
        _controller.connectGallery();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        height: getProportionateScreenHeight(50),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Icon(
              Icons.add_photo_alternate_outlined,
              color: kPrimaryColor,
            ),
            SizedBox(width: getProportionateScreenWidth(kDefaultPadding)),
            Text("Galeri"),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
