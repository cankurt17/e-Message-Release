import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/data/models/like.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class LikesBottomSheet extends StatelessWidget {
  final String postID;

  LikesBottomSheet({Key key, this.postID}) : super(key: key);

  PostController _controller = Get.find<PostController>();

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
      child: StreamBuilder<List<Like>>(
        stream: _controller.getAllLikes(postID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CustomLoaderPhoto(
                        height: getProportionateScreenHeight(45),
                        photoUrl: snapshot.data[index].profileUrl,
                      ),
                      SizedBox(
                          width:
                              getProportionateScreenWidth(kDefaultPadding / 2)),
                      Text(
                        snapshot.data[index].username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
