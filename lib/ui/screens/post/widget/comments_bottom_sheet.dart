import 'package:flutter/material.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/post/widget/comment_detail.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class CommentsBottomSheet extends StatelessWidget {
  final Post post;

  CommentsBottomSheet({Key key, this.post}) : super(key: key);
  PostController _controller = PostController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: getProportionateScreenWidth(kDefaultPadding / 2),
          left: getProportionateScreenWidth(kDefaultPadding / 2)),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Comment>>(
              stream: _controller.getComment(post.postId),
              builder: (context, commentSnapshot) {
                if (commentSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: commentSnapshot.data.length,
                    itemBuilder: (context, index) {
                      if (commentSnapshot.data.length > 0) {
                        return CommentDetail(
                          comment: commentSnapshot.data[index],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          buildCommentTextField(),
        ],
      ),
    );
  }

  Padding buildCommentTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(kDefaultPadding / 2),
      ),
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) {
                  _controller.sendComment(post);
                },
                controller: _controller.commentTextController,
                decoration: InputDecoration(hintText: "Yorum ekle..."),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(kDefaultPadding / 2)),
            InkWell(
              onTap: () {
                _controller.sendComment(post);
              },
              child: Container(
                height: getProportionateScreenHeight(50),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Icon(
                  Icons.arrow_upward,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
