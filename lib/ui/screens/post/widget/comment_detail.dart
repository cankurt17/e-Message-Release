import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class CommentDetail extends StatelessWidget {
  CommentDetail({Key key, this.comment}) : super(key: key);
  final Comment comment;
  PostController _controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLoaderPhoto(
                height: getProportionateScreenHeight(45),
                photoUrl: comment.profileUrl,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(kDefaultPadding / 4),
                      right: getProportionateScreenWidth(kDefaultPadding)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(comment.commentText),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: kDefaultPadding),
                child: Text(
                  comment.date != null
                      ? _controller.currentDate(comment.date, DateTime.now())
                      : "",
                  style: TextStyle(color: kIconColor),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
          Container(
            width: SizeConfig.screenWidth * 0.8,
            height: 1,
            color: Color(0xFFF1F1F1),
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
        ],
      ),
    );
  }
}
