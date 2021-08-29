import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/repository/user_repository.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                width: 100,
                child: Image(
                  image:
                      NetworkImage(Get.find<HomeController>().user.profilUrl),
                ),
              ),
              Text(Get.find<HomeController>().user.userID.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
