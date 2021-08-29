import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_chat/data/services/notification_helper.dart';
import 'package:online_chat/routes/app_pages.dart';
import 'package:online_chat/routes/app_routes.dart';
import 'package:online_chat/ui/theme.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetStorage _database = GetStorage('login_firebase');
  FirebaseMessaging.onBackgroundMessage(backgroundHandler); 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData(context),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.list,
    );
  }
}
