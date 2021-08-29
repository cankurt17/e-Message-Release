import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/signup/widgets/body.dart';
import 'package:online_chat/ui/size_config.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SignupBody(),
    );
  }
}
