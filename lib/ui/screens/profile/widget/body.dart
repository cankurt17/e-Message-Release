import 'package:flutter/material.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/profile/widget/profile_content.dart';
import 'package:online_chat/ui/screens/profile/widget/post_content.dart';
import 'package:online_chat/ui/size_config.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            ProfileContent(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContent(Icons.insert_comment_outlined),
              ],
            ),
            PostContent(),
          ],
        ),
      ),
    );
  }

  Expanded buildContent(IconData icon) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(width: getProportionateScreenWidth(20)),
                Text(
                  "Gönderiler",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding / 2),
            Container(
              height: 2,
              color: kSecondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
