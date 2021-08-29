import 'package:flutter/material.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/ui/screens/post/widget/post_detail.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';

class PostBody extends StatelessWidget {
  PostController _controller = PostController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _controller.getAllPost(),
        builder: (context, postSnapshot) {
          if (postSnapshot.hasData) {
            if (postSnapshot.data.length > 0) {
              return ListView.builder(
                itemCount: postSnapshot.data.length,
                itemBuilder: (context, index) {
                  Post post = postSnapshot.data[index];
                  return PostDetail(
                    post: post,
                  );
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
    );
  }
}
