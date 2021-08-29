import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/users_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/users/widget/call_buton.dart';
import 'package:online_chat/ui/screens/users/widget/message_button.dart';
import 'package:online_chat/ui/screens/users/widget/user_state_color.dart';
import 'package:online_chat/ui/screens/users/widget/video_call_button.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class UsersBody extends StatelessWidget {
  UsersController _usersController = Get.find<UsersController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      width: double.infinity,
      child: buildUserList(),
    );
  }

  StreamBuilder buildUserList() {
    return StreamBuilder<List<UserModel>>(
      stream: _usersController.getAllUsers(),
      builder: (context, userList) {
        if (!userList.hasData) {
          return CustomProggesIndicator();
        } else {
          List<UserModel> allUsers = userList.data;
          return ListView.builder(
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              UserModel _user = allUsers[index];
              if (_user.userID != _usersController.fromUser.userID &&
                  _user.complete == true) {
                return buildUserContent(_user);
              } else {
                return Container();
              }
            },
          );
        }
      },
    );
  }

  Column buildUserContent(UserModel _user) {
    return Column(
      children: [
        Container(
          height: getProportionateScreenHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildPhoto(_user),
              buildTitle(_user),
              _user.userName == "Cankurt"
                  ? Row(
                      children: [
                        SizedBox(width: getProportionateScreenWidth(10)),
                        Container(
                            width: getProportionateScreenHeight(20),
                            child: Image.asset("assets/images/checked.png")),
                      ],
                    )
                  : Container(),
              Spacer(),
              UserStateColor(user: _user),
              SizedBox(width: getProportionateScreenWidth(kDefaultPadding / 2)),
              VideoCallButton(),
              CallButton(),
              MessageButton(
                toUser: _user,
              ),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Container(height: 1, color: Color(0xFFF1F1F1)),
        SizedBox(height: getProportionateScreenHeight(10)),
      ],
    );
  }

  Widget buildPhoto(UserModel _user) {
    return InkWell(
      onTap: () {
        Get.toNamed("/profile", arguments: _user.userID);
      },
      child: Hero(
        tag: _user.userID,
        child: CustomLoaderPhoto(
          height: getProportionateScreenHeight(50),
          photoUrl: _user.profilUrl,
        ),
      ),
    );
  }

  Padding buildTitle(UserModel _user) {
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding),
      child: Text(
        _user.userName,
        style: TextStyle(color: kSecondaryColor, fontSize: 16),
      ),
    );
  }
}
