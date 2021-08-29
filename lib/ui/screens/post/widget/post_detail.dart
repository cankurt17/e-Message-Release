import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/post/widget/comments_bottom_sheet.dart';
import 'package:online_chat/ui/screens/post/widget/likes_bottom_sheet.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail({Key key, this.post}) : super(key: key);

  PostController _controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onDoubleTap: () {
              _controller.sendLike(post, post.like);
            },
            child: Column(
              children: [
                buildPostTitle(context),
                SizedBox(
                    height: getProportionateScreenHeight(kDefaultPadding / 2)),
                buildPostText(),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
          buildLikesRow(context),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 4)),
          buildCommentsRow(context),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
          Center(
            child: Container(
              width: SizeConfig.screenWidth * 0.8,
              height: 2,
              color: Color(0xFFF1F1F1),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding / 2)),
        ],
      ),
    );
  }

  Container buildCommentsRow(BuildContext context) {
    return Container(
      child: post.comments != "0"
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    return showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: CommentsBottomSheet(
                            post: post,
                          ),
                        );
                      },
                    );
                  },
                  child: Text(post.comments.toString() + " yorumun tümünü gör",
                      style: TextStyle(color: kIconColor)),
                ),
                SizedBox(
                    height: getProportionateScreenHeight(kDefaultPadding / 4)),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_right,
                      color: kIconColor,
                      size: getProportionateScreenHeight(20),
                    ),
                    Text(
                      post.lastUsername,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        width:
                            getProportionateScreenWidth(kDefaultPadding / 4)),
                    Text(
                      post.lastComment,
                      style: TextStyle(color: kIconColor),
                    )
                  ],
                ),
              ],
            )
          : Container(),
    );
  }

  Container buildLikesRow(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              return showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: LikesBottomSheet(
                      postID: post.postId,
                    ),
                  );
                },
              );
            },
            child: Text(
              post.likes.toString() + " beğenme",
              style: TextStyle(color: kIconColor, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          StreamBuilder(
            stream: _controller.likeControl(post.postId),
            builder: (context, snapshot) {
              post.like = snapshot.data;
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return InkWell(
                    onTap: () {
                      _controller.sendDislike(post.postId);
                    },
                    child: Icon(
                      Icons.favorite,
                      size: getProportionateScreenHeight(26),
                      color: Colors.red,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      _controller.sendLike(post, post.like);
                    },
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: getProportionateScreenHeight(26),
                      color: kIconColor,
                    ),
                  );
                }
              } else {
                return Container();
              }
            },
          ),
          SizedBox(width: getProportionateScreenWidth(kDefaultPadding / 2)),
          InkWell(
            onTap: () {
              return showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CommentsBottomSheet(
                      post: post,
                    ),
                  );
                },
              );
            },
            child: Icon(
              Icons.textsms_outlined,
              color: kIconColor,
              size: getProportionateScreenHeight(26),
            ),
          ),
        ],
      ),
    );
  }

  Wrap buildPostText() {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          width: double.infinity,
          child: Text(post.postText),
        )
      ],
    );
  }

  Row buildPostTitle(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (post.userID != _controller.fromUser.userID) {
              Get.toNamed("/profile", arguments: post.userID);
            }
          },
          child: CustomLoaderPhoto(
            height: 50,
            photoUrl: post.profileURl,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                post.username,
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                post.date != null ? _controller.readTimestamp(post.date) : "",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    color: kIconColor),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding / 2),
          child: Text(post.date != null
              ? _controller.currentDate(post.date, DateTime.now())
              : ""),
        ),
      ],
    );
  }
}
