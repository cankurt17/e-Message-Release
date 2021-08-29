import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String postID;
  String commentID;
  String commentText;
  String username;
  String profileUrl;
  Timestamp date;

  Comment({
    this.postID,
    this.commentID,
    this.commentText,
    this.username,
    this.profileUrl,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'commentID': commentID,
      'commentText': commentText,
      'username': username,
      'profileUrl': profileUrl,
      'date': date ?? FieldValue.serverTimestamp(),
    };
  }

  Comment.fromMap(Map<String, dynamic> map)
      : postID = map['postID'],
        commentID = map['commentID'],
        commentText = map['commentText'],
        username = map['username'],
        profileUrl = map['profileUrl'],
        date = map['date'];

  @override
  String toString() {
    return 'Comment(postID: $postID, commentID: $commentID, commentText: $commentText, username: $username, profileUrl: $profileUrl, date: $date)';
  }
}
