import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/ui/constants.dart';

class UsernameAndLastSeen extends StatelessWidget {
  const UsernameAndLastSeen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.userName,
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 16,
          ),
        ),
        StreamBuilder(
          stream: Get.find<ChatController>().getChatDetails(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.hasData) {
              return Text(
                Get.find<ChatController>().currentDate(
                    user, user.updateAt, DateTime.now(), chatSnapshot.data),
                style: TextStyle(
                  color: kTextLightColor,
                  fontSize: 12,
                ),
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}
