import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/message_controller.dart';
import 'package:online_chat/data/models/chats.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class MessageContent extends StatelessWidget {
  MessageController _controller = Get.find<MessageController>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chats>>(
      stream: _controller.getAllChats(),
      builder: (context, streamChatList) {
        if (!streamChatList.hasData) {
          return CustomProggesIndicator();
        } else {
          var allChat = streamChatList.data;
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
            child: buildChatList(allChat),
          );
        }
      },
    );
  }

  FutureBuilder buildChatList(List<Chats> allChat) {
    return FutureBuilder(
      future: _controller.getDate(),
      builder: (context, dateTime) {
        DateTime date;
        if (dateTime.hasData) {
          date = dateTime.data;
        } else {
          date = null;
        }
        return ListView.builder(
          itemCount: allChat.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    _controller.openChat(allChat[index].toUser);
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.toNamed("/profile",
                                      arguments: allChat[index].toUser);
                                },
                                child: Hero(
                                  tag: allChat[index].toUser,
                                  child: buildPhoto(
                                      allChat[index].receiverPhotoUrl),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTitle(allChat[index].receiverUsername),
                                SizedBox(
                                    height: getProportionateScreenHeight(5)),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: kDefaultPadding),
                                  child: buildLastMessage(allChat, index),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildCreateDate(
                                    allChat[index].createDate, date),
                                SizedBox(
                                    height: getProportionateScreenHeight(8)),
                                StreamBuilder(
                                  stream: _controller
                                      .getAllNewMessage(allChat[index].toUser),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int sumMessage = snapshot.data.length;
                                      print(snapshot.data.length);
                                      if (sumMessage > 0) {
                                        return Container(
                                          height:
                                              getProportionateScreenHeight(30),
                                          width:
                                              getProportionateScreenHeight(30),
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Text(
                                              sumMessage.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Container(height: 1, color: Color(0xFFF1F1F1)),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
              ],
            );
          },
        );
      },
    );
  }

  Column buildCreateDate(Timestamp createDate, DateTime date) {
    if (date != null) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: kDefaultPadding / 2),
            child: FutureBuilder(
              future: _controller.currentDate(createDate, date),
              builder: (context, date) {
                if (date.hasData) {
                  return Text(
                    date.data,
                    style: TextStyle(
                      color: kTextLightColor,
                      fontSize: getProportionateScreenWidth(11),
                    ),
                  );
                } else {
                  return Text(
                    "...",
                    style: TextStyle(color: kTextLightColor),
                  );
                }
              },
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: kDefaultPadding / 2),
            child: Text(
              "...",
              style: TextStyle(color: kTextLightColor),
            ),
          ),
        ],
      );
    }
  }

  Padding buildLastMessage(List<Chats> allChat, int index) {
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding / 20),
      child: Text(
        allChat[index].lastMessage.length > 20
            ? allChat[index].lastMessage.substring(0, 20) + " ..."
            : allChat[index].lastMessage,
        style: TextStyle(
            color: kTextLightColor, fontSize: getProportionateScreenWidth(14)),
      ),
    );
  }

  CustomLoaderPhoto buildPhoto(String photoUrl) {
    return CustomLoaderPhoto(
      height: getProportionateScreenHeight(50),
      photoUrl: photoUrl,
    );
  }

  Padding buildTitle(String username) {
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding),
      child: Text(
        username,
        style: TextStyle(
            color: kSecondaryColor, fontSize: getProportionateScreenWidth(16)),
      ),
    );
  }
}
