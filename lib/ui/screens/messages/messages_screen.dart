import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/messages/widget/body.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konuşmalar"),
      ),
      body: MessageBody(),
    );
  }
}
