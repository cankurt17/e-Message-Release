import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class MyChatBallon extends StatelessWidget {
  MyChatBallon({
    Key key,
    @required this.allMessage,
    this.index,
    this.date,
  }) : super(key: key);

  final List<Message> allMessage;
  final int index;
  final String date;
  ChatController _controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: _controller.deleteMod == true
            ? () => _controller.selectedDeleteMessage(
                index, allMessage[index].messageID)
            : null,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(4),
                horizontal: getProportionateScreenWidth(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(flex: 1),
                    Flexible(
                      flex: 2,
                      child: InkWell(
                        onLongPress: () => _controller.setDeleteMod(true),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenWidth(4),
                              horizontal: getProportionateScreenWidth(8)),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: InkWell(
                            onTap: _controller.deleteMod == true
                                ? () => _controller.selectedDeleteMessage(
                                    index, allMessage[index].messageID)
                                : null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                messageType(allMessage[index].type),
                                SizedBox(
                                    height: getProportionateScreenHeight(5)),
                                buildIconAndDate(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _controller.deleteMod == true
                        ? Radio(
                            value: allMessage[index].messageID.toString(),
                            groupValue: _controller.radioList[index].toString(),
                            onChanged: (value) {
                              _controller.selectedDeleteMessage(
                                  index, allMessage[index].messageID);
                            },
                            activeColor: kPrimaryColor,
                            toggleable: true,
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextMessage() {
    return Container(
      child: Text(
        allMessage[index].message + "           ",
      ),
    );
  }

  Container buildIconAndDate() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            _controller.getChatIcon(allMessage[index]),
            size: 14,
            color: kSecondaryColor,
          ),
          SizedBox(width: getProportionateScreenWidth(5)),
          Text(
            date,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget messageType(String type) {
    if (type == "str") {
      return buildTextMessage();
    } else if (type == "photo") {
      return buildPhotoMessage();
    }
  }

  Container buildPhotoMessage() {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(SizeConfig.screenWidth / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kSecondaryColor),
      ),
      child: FadeInImage(
        placeholder: AssetImage("assets/images/loader.gif"),
        image: NetworkImage(allMessage[index].photo),
        fit: BoxFit.fill,
      ),
    );
  }
}
