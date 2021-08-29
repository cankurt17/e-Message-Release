import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/users_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/ui/screens/users/widget/custom_icon.dart';

class MessageButton extends StatelessWidget {
  final UserModel toUser;
  const MessageButton({Key key, this.toUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<UsersController>().pressMessageButton(toUser),
      child: CustomIcon(icon: Icons.chat_bubble_outline),
    );
  }
}
