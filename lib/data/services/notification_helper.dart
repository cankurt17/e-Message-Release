import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  NotificationHelper.display(message);
  return Future<void>.value();
}

subscribeToTopic(String topic) async {
  await FirebaseMessaging.instance.subscribeToTopic(topic);
}

class NotificationHelper {
  static FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final NotificationHelper _singleton = NotificationHelper._internal();

  static UserRepository _userRepository = UserRepository();
  NotificationHelper._internal();

  factory NotificationHelper() => _singleton;

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectedNotification);

    String token = await _singleton.getToken();

    await _userRepository.saveToken(
        Get.find<HomeController>().user.userID, token);
  }

  static void display(RemoteMessage message) async {
   

    var mesaj = Person(
      name: message.data["title"],
      key: '1',
    );
    var mesajStyle = MessagingStyleInformation(mesaj,
        htmlFormatTitle: true,
        htmlFormatContent: true,
        groupConversation: true,
        messages: [
          Message(
            message.data["body"],
            DateTime.now(),
            mesaj,
          )
        ]);
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      print(id);
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "e-Message", "e-Message channel", "this is your channel",
            styleInformation: mesajStyle,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker'),
      );

      await _notificationsPlugin.show(
          id, message.data["title"], message.data["body"], notificationDetails,
          payload: json.encode(message.data));
    } catch (e) {
      print("Hata çıktı : " + e.toString());
    }
  }

  Future<String> getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  static Future onSelectedNotification(String payload) async {
    if (payload != null) {
      Map mapPayload = json.decode(payload);

      if (mapPayload["type"] == "message") {
        UserRepository _userRepository = UserRepository();
        UserModel fromUser = Get.find<HomeController>().user;
        UserModel toUser = await _userRepository.getUser(mapPayload["userID"]);
        Get.toNamed('/chat', arguments: [fromUser, toUser]);
      }
    }
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
