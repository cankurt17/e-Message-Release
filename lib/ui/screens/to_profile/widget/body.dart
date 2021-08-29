import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/to_profile_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/to_profile/widget/profile_detail.dart';
import 'package:online_chat/ui/screens/to_profile/widget/profile_post_detail.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_circular_indicator.dart';
import 'package:online_chat/widgets/custom_loader_photo.dart';

class ToProfileBody extends StatelessWidget {
  ToProfileController _controller = ToProfileController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding / 4),
        child: Column(
          children: [
            ToProfileDetail(),
            ToProfilePostDetail()
          ],
        ),
      ),
    );
  }
}
