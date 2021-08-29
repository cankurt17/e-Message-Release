import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/controller/profile_controller.dart';
import 'package:online_chat/controller/to_profile_controller.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/post/widget/post_detail.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';

class ToProfilePostDetail extends StatelessWidget {
  ToProfileController _controller = ToProfileController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: Get.find<PostController>().getAllPost(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.hasData) {
                    if (postSnapshot.data.length > 0) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: postSnapshot.data.length,
                        itemBuilder: (context, index) {
                          Post post = postSnapshot.data[index];
                          if (post.userID ==
                              Get.find<ToProfileController>().toUserID) {
                            return PostDetail(
                              post: post,
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return CustomProggesIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
