import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

import 'media_bottom_sheet.dart';

class ChatTextField extends StatelessWidget {
  ChatController _controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 70,
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
        child: Row(
          children: [
            buildTextField(),
            _controller.focus != true ? buildMediaRow() : Container(),
            buildSendMessageButton(),
          ],
        ),
      ),
    );
  }

  Row buildMediaRow() {
    return Row(
      children: [
        buildMediaButton(),
      ],
    );
  }

  InkWell buildMediaButton() {
    return InkWell(
      onTap: () {
        if (_controller.loadingPhoto == false) {
          _controller.imageFile = null;
        }
        Get.bottomSheet(MediaBottomSheet());
      },
      child: Container(
        height: getProportionateScreenHeight(50),
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: Icon(
          Icons.photo_library_outlined,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  InkWell buildSendMessageButton() {
    return InkWell(
      onTap: () {
        _controller.sendMessage(type: "str");
      },
      child: Container(
        height: getProportionateScreenHeight(50),
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: Icon(
          Icons.arrow_upward,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Expanded buildTextField() {
    return Expanded(
      child: Focus(
        onFocusChange: (value) => _controller.focus = value,
        child: TextField(
          onChanged: (value) {
            _controller.changeWrite();
          },
          controller: _controller.messageTextController,
          decoration: InputDecoration(hintText: "Mesajınızı yazın"),
        ),
      ),
    );
  }
}
