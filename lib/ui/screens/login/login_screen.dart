import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/login/widgets/body.dart';
import 'package:online_chat/ui/size_config.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: LoginBody(),
    );
  }
}
