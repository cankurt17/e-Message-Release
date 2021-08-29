import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  String postID;
  String userID;
  String username;
  String profileUrl;

  Like({
    this.postID,
    this.userID,
    this.username,
    this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'userID': userID,
      'username': username,
      'profileUrl': profileUrl,
    };
  }

  Like.fromMap(Map<String, dynamic> map)
      : postID = map['postID'],
        userID = map['userID'],
        username = map['username'],
        profileUrl = map['profileUrl'];
}
