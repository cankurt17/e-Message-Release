import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/ui/screens/chat/widgets/my_chat_ballon.dart';
import 'package:online_chat/ui/screens/chat/widgets/receiver_chat_ballon.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';

class ChatContent extends StatelessWidget {
  ChatController _controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Message>>(
        stream: _controller.getMessages(),
        builder: (context, streamMessageList) {
          if (!streamMessageList.hasData) {
            return CustomProggesIndicator();
          } else {
            var allMessage = streamMessageList.data;
            return buildListView(allMessage);
          }
        },
      ),
    );
  }

  ListView buildListView(List<Message> allMessage) {
    return ListView.builder(
      reverse: true,
      controller: _controller.scrollController,
      itemCount: allMessage.length,
      itemBuilder: (context, index) {
        String date;
        try {
          date =
              _controller.getHourAdnMinute(allMessage[index].date.toDate()) ??
                  Timestamp(1, 1).toDate();
        } catch (e) {
          date = "           ";
        }
        _controller.radioList.add("");
        if (allMessage[index].fromMe) {
          return MyChatBallon(
            allMessage: allMessage,
            index: index,
            date: date,
          );
        } else {
          if (allMessage[index].seen == "1") {
            _controller.seenMessage(allMessage[index].messageID);
          }
          return ReceiverChatBallon(
            allMessage: allMessage,
            index: index,
            date: date,
          );
        }
      },
    );
  }
}
