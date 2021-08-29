import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/body.dart';

class CompleteLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CompleteLoginBody(),
    );
  }
}
