import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/users/widget/body.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişiler"),
      ),
      body: UsersBody(),
    );
  }
}
