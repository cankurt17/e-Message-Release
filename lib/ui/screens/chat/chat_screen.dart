import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/chat/widgets/body.dart';
import 'package:online_chat/ui/screens/chat/widgets/username_and_last_seen.dart';
import 'package:online_chat/ui/screens/users/widget/call_buton.dart';
import 'package:online_chat/ui/screens/users/widget/video_call_button.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class ChatScreen extends StatelessWidget {
  ChatController _controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: buildTheme(context),
        child: Scaffold(
          appBar:
              _controller.deleteMod == true ? deleteAppBar() : buildAppBar(),
          body: ChatBody(),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: StreamBuilder<UserModel>(
        stream: _controller.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data;
            return Row(
              children: [
                Hero(
                  tag: user.userID,
                  child: CustomLoaderPhoto(
                    photoUrl: user.profilUrl,
                    height: getProportionateScreenHeight(45),
                  ),
                ),
                SizedBox(
                    width: getProportionateScreenWidth(kDefaultPadding / 2)),
                UsernameAndLastSeen(user: user),
                Spacer(),
                VideoCallButton(),
                CallButton(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  AppBar deleteAppBar() {
    return AppBar(
      toolbarHeight: getProportionateScreenHeight(50),
      title: Row(
        children: [
          Spacer(),
          InkWell(
              onTap: () => _controller.deleteMessage(),
              child: Icon(Icons.delete_outline)),
          SizedBox(width: getProportionateScreenWidth(20)),
          InkWell(
            onTap: () => _controller.setDeleteMod(false),
            child: Icon(
              Icons.close,
              color: kIconColor,
            ),
          ),
        ],
      ),
    );
  }

  ThemeData buildTheme(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: kTextLightColor),
      gapPadding: 10,
    );
    return Theme.of(context).copyWith(
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusColor: kPrimaryColor,
            border: outlineInputBorder,
          ),
    );
  }
}
