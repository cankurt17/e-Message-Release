import 'package:flutter/material.dart';
import 'package:online_chat/ui/screens/users/widget/custom_icon.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

class VideoCallButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        customSnackBar(
          "Uyarı!",
          "Beta sürümde bu özellik kullanılamamaktadır.",
          icon: Icons.info,
          color: Colors.orange,
        );
      },
      child: CustomIcon(icon: Icons.videocam_outlined),
    );
  }
}
