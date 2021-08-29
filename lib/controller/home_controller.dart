import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/message_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:online_chat/data/services/notification_helper.dart';
import 'package:online_chat/ui/screens/location/location_screen.dart';
import 'package:online_chat/ui/screens/messages/messages_screen.dart';
import 'package:online_chat/ui/screens/post/post_screen.dart';
import 'package:online_chat/ui/screens/profile/profile_screen.dart';
import 'package:online_chat/ui/screens/users/users_screen.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final UserModel user = Get.arguments;
  var _selectedNavBarIndex = 2.obs;

  UserRepository _userRepository = UserRepository();

  List<Widget> screens = [
    LocationScreen(),
    UsersScreen(),
    PostScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  get selectedNavBarIndex => this._selectedNavBarIndex.value;

  set selectedNavBarIndex(var value) => this._selectedNavBarIndex.value = value;

  void changeTabBar(int index) async {
    selectedNavBarIndex = index;
    if (index == 2) {
      await Get.find<MessageController>().getDate();
    }
  }

  void initialize(BuildContext context) async {
    NotificationHelper.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          print(message);
          NotificationHelper.display(message);
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message != null) {
          if (Get.find<HomeController>().selectedNavBarIndex != 3 &&
              message.data["type"] == "message") {
            customSnackBar(message.data["title"], message.data["body"],
                icon: Icons.textsms,
                color: Colors.green,
                onTap: (snack) => NotificationHelper.onSelectedNotification(
                    json.encode(message.data)));
          } else if (message.data["type"] == "like") {
            customSnackBar(
              message.data["title"], message.data["body"],
                icon: Icons.thumb_up,
                color: Colors.blue,
                onTap: (snack) => NotificationHelper.onSelectedNotification(
                    json.encode(message.data)));
          } else if (message.data["type"] == "comment") {
            customSnackBar(message.data["title"], message.data["body"],
                icon: Icons.question_answer_outlined,
                color: Colors.orange,
                onTap: (snack) => NotificationHelper.onSelectedNotification(
                    json.encode(message.data)));
          }
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        print(message);
      }
      NotificationHelper.display(message);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() async {
    WidgetsBinding.instance.removeObserver(this);
    changeOffline();
    super.onClose();
  }

  void onInit() async {
    changeOnline();
    super.onInit();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(user.userID);
    if (state == AppLifecycleState.resumed) {
      await changeOnline();
    } else {
      await changeOffline();
    }
  }

  Future<void> changeOnline() async {
    await _userRepository.changeUserOnline(user.userID, true);
  }

  Future<void> changeOffline() async {
    await _userRepository.changeUserOnline(user.userID, false);
  }
}
