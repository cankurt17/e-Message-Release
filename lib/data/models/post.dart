import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String postText;
  Timestamp date;
  String likes;
  String comments;
  String lastComment;
  String lastUsername;
  String userID;
  String username;
  String profileURl;
  bool like;

  Post(
      {this.postId,
      this.postText,
      this.date,
      this.likes,
      this.comments,
      this.lastComment,
      this.lastUsername,
      this.userID,
      this.username,
      this.like,
      this.profileURl});

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'postText': postText,
      'date': date ?? FieldValue.serverTimestamp(),
      'likes': likes ?? 0,
      'comments': comments ?? 0,
      'lastComment': lastComment ?? "",
      'lastUsername': lastUsername ?? "",
      'userID': userID,
      'username': username,
      'profileURl': profileURl,
    };
  }

  Post.fromMap(Map<String, dynamic> map)
      : postId = map['postId'],
        postText = map['postText'],
        date = map['date'],
        likes = (map['likes'] as int).toString(),
        comments = (map['comments'] as int).toString(),
        lastComment = map['lastComment'],
        lastUsername = map['lastUsername'],
        userID = map['userID'],
        username = map['username'],
        profileURl = map['profileURl'];

  @override
  String toString() {
    return 'Post(postId: $postId, postText: $postText, date: $date, likes: $likes, comments: $comments, lastComment: $lastComment, lastUsername: $lastUsername, userID: $userID, username: $username, profileURl: $profileURl)';
  }
}
