import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/ui/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _userModel;
  int a = 1;
  HomeController _controller = Get.find<HomeController>();
  @override
  void initState() {
    Get.find<HomeController>().initialize(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeController _controller = Get.find<HomeController>();
    return Obx(
      () => Scaffold(
        body: _controller.screens[_controller.selectedNavBarIndex],
        bottomNavigationBar: buildFlashyTabBar(_controller),
      ),
    );
  }

  FlashyTabBar buildFlashyTabBar(HomeController _controller) {
    return FlashyTabBar(
      selectedIndex: _controller.selectedNavBarIndex,
      onItemSelected: (value) => _controller.changeTabBar(value),
      animationDuration: new Duration(milliseconds: 300),
      showElevation: true,
      iconSize: 24,
      items: [
        FlashyTabBarItem(
          inactiveColor: kIconColor,
          icon: Icon(Icons.person_pin_circle_outlined),
          activeColor: kSecondaryColor,
          title: Text('Konum'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.people_alt_outlined),
          inactiveColor: kIconColor,
          activeColor: kSecondaryColor,
          title: Text('Kişiler'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.home_outlined),
          inactiveColor: kIconColor,
          activeColor: kSecondaryColor,
          title: Text('Anasayfa'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.forum_outlined),
          inactiveColor: kIconColor,
          activeColor: kSecondaryColor,
          title: Text('Mesajlar'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.person_outline),
          inactiveColor: kIconColor,
          activeColor: kSecondaryColor,
          title: Text('Profil'),
        ),
      ],
    );
  }
}
