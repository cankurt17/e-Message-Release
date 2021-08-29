import 'package:flutter/material.dart';
import 'package:online_chat/data/models/user.dart';

class UserStateColor extends StatelessWidget {
  const UserStateColor({Key key, this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: user.online == true ? Colors.green : Color(0xFFD54C4C),
      ),
    );
  }
}
