import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/post/widget/add_post.dart';
import 'package:online_chat/ui/screens/post/widget/body.dart';
import 'package:online_chat/ui/screens/profile/widget/post_content.dart';
import 'package:online_chat/ui/size_config.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Gönderiler"),
            Spacer(),
            InkWell(
              onTap: () {
                Get.find<PostController>().signOut();
              },
              child: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Post',
            content: AddPost(),
            barrierDismissible: false,
          );
        },
        child: Icon(Icons.add, size: getProportionateScreenHeight(30)),
        backgroundColor: kPrimaryColor,
      ),
      body: PostBody(),
    );
  }
  
}
