import 'package:flutter/material.dart';

class CustomLoaderPhoto extends StatelessWidget {
  final double height;
  final String photoUrl;
  final Color borderColor;

  const CustomLoaderPhoto(
      {Key key,
      this.height,
      this.photoUrl,
      this.borderColor: Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipOval(
          child: FadeInImage(
            placeholder: AssetImage("assets/images/loader.gif"),
            image: NetworkImage(photoUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
