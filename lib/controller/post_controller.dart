import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_chat/animation/loading_dialog.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/data/models/like.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:online_chat/data/services/auth_services.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostController extends GetxController {
  UserModel fromUser = Get.find<HomeController>().user;
  UserRepository _userRepository = UserRepository();
  TextEditingController postTextController = TextEditingController();
  TextEditingController commentTextController = TextEditingController();

  void sendPost() async {
    if (postTextController.text != "") {
      showLoading();
      Post post = Post(
        postText: postTextController.text,
        userID: fromUser.userID,
        username: fromUser.userName,
        profileURl: fromUser.profilUrl,
      );
      await _userRepository.sendPost(post);
      dismissLoading();
      Get.back();
      postTextController.clear();
    }
  }

  Stream<List<Post>> getAllPost() {
    return _userRepository.getAllPost();
  }

  String currentDate(Timestamp createDate, DateTime dateTime) {
    var _duration = dateTime.difference(createDate.toDate());
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    String differenceDate =
        timeago.format(dateTime.subtract(_duration), locale: "tr");
    return differenceDate;
  }

  String readTimestamp(Timestamp timestamp) {
    DateTime _date = timestamp.toDate();
    DateFormat _dateFotmat = DateFormat('dd-MM-yyyy hh:mm');
    return _dateFotmat.format(_date);
  }

  void sendComment(Post post) async {
    if (commentTextController.text != "") {
      showLoading();
      Comment comment = Comment(
        postID: post.postId,
        commentText: commentTextController.text,
        profileUrl: fromUser.profilUrl,
        username: fromUser.userName,
      );
      await _userRepository.sendComment(post, comment, fromUser);
      dismissLoading();
      commentTextController.clear();
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  Stream<List<Comment>> getComment(String postID) {
    return _userRepository.getComment(postID);
  }

  void sendLike(Post post, bool like) async {
    if (like == false) {
      Like like = Like(
        postID: post.postId,
        userID: fromUser.userID,
        username: fromUser.userName,
        profileUrl: fromUser.profilUrl,
      );
      await _userRepository.sendLike(post, fromUser, like);
    }
  }

  Stream<bool> likeControl(String postID) {
    return _userRepository.likeControl(postID, fromUser.userID);
  }

  void sendDislike(String postID) async {
    await _userRepository.sendDislike(postID, fromUser.userID);
  }

  Stream<List<Like>> getAllLikes(String postID) {
    return _userRepository.getAllLikes(postID);
  }

  void signOut() async {
    await _userRepository.signOut();
    await _userRepository.saveToken(fromUser.userID, "");
    Get.offAllNamed("/login");
  }
}
