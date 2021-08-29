import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_chat/data/models/chats.dart';
import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/data/models/like.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/data/models/user.dart';

abstract class FirebaseHelperBase {
  Future<bool> saveUser(UserModel user);
  Future<bool> sendEmailVerification(User user);
  Future<UserModel> readUser(String userID);
  Future<bool> usernameControl(String username);
  Future<bool> completeUser(UserModel user);
  Stream<List<UserModel>> getAllUsers();
  Stream<List<Message>> getMessages(String fromUserID, String toUserID);
  Future<bool> saveMessage(
      Message currentMessage, UserModel fromUser, UserModel toUser);
  Future<bool> deleteMessages(
      String fromUserID, String toUserID, List messageList);
  Stream<List<Chats>> getAllChats(String fromUserID);
  Future<DateTime> currentDate(String userID);
  Future<bool> saveToken(String userID, String token);
  Future<String> getToken(String userID);
  Future<bool> changeUserOnline(String userID, bool online);
  Stream<UserModel> getUserDetails(String userID);
  Future<bool> changeWrite(UserModel fromUser, UserModel toUser, bool write);
  Stream<Chats> getChatDetails(UserModel fromUser, UserModel toUser);
  Future<bool> seenMessage(
      UserModel fromUser, UserModel toUser, String messageID);
  Future<bool> sendPost(Post post);
  Stream<List<Post>> getAllPost();
  Future<bool> sendComment(Post post, Comment comment, UserModel currentUser);
  Stream<List<Comment>> getComment(String postID);
  Future<bool> sendLike(Post post, UserModel currentUser, Like like);
  Stream<bool> likeControl(String postID, String userID);
  Future<bool> sendDislike(String postID, String userID);
  Stream<List<Like>> getAllLikes(String postID);
  Stream<List<Message>> getAllNewMessage(String fromUserID, String toUserID);
  Future<bool> updateProfilePhoto(String userID, String photoUrl);
  Future<bool> deletePost(String postID);
}
