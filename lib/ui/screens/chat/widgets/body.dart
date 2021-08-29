import 'package:flutter/material.dart'; 
import 'package:online_chat/ui/screens/chat/widgets/chat_content.dart';
import 'package:online_chat/ui/screens/chat/widgets/chat_text_field.dart';

class ChatBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            ChatContent(),
            ChatTextField(),
          ],
        ),
      ),
    );
  }
}
