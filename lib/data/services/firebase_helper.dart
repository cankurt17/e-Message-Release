import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_chat/animation/loading_dialog.dart';
import 'package:online_chat/data/models/chats.dart';
import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/data/models/like.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/services/base/firebase_helper_base.dart';

class FirebaseHelper extends FirebaseHelperBase {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel user) async {
    DocumentSnapshot _readUser =
        await _firebase.doc('users/${user.userID}').get();
    if (_readUser.data() == null) {
      await _firebase.collection("users").doc(user.userID).set(user.toMap());
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> sendEmailVerification(User user) async {
    try {
      await user.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> readUser(String userID) async {
    DocumentSnapshot _readUser =
        await _firebase.collection("users").doc(userID).get();

    return UserModel.fromMap(_readUser.data());
  }

  Future<bool> usernameControl(String username) async {
    var querySnapshot = await _firebase
        .collection("users")
        .where("userName", isEqualTo: username)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  @override
  Future<bool> completeUser(UserModel user) async {
    await _firebase.collection("users").doc(user.userID).update({
      'profilUrl': user.profilUrl,
      'userName': user.userName,
      'gender': user.gender,
      'complete': user.complete
    });
    return true;
  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    var snapshot = _firebase.collection("users").snapshots();

    return snapshot.map((allUsers) =>
        allUsers.docs.map((user) => UserModel.fromMap(user.data())).toList());
  }

  @override
  Stream<List<Chats>> getAllChats(String fromUserID) {
    var snapshot = _firebase
        .collection("chats")
        .where("fromUser", isEqualTo: fromUserID)
        .orderBy("createDate", descending: true)
        .snapshots();

    return snapshot.map((chatList) =>
        chatList.docs.map((chat) => Chats.fromMap(chat.data())).toList());
  }

  @override
  Stream<List<Message>> getMessages(String fromUserID, String toUserID) {
    var snapshot = _firebase
        .collection("chats")
        .doc(fromUserID + "--" + toUserID)
        .collection("messages")
        .orderBy("date", descending: true)
        .snapshots();
    return snapshot.map((messageList) => messageList.docs
        .map((message) => Message.fromMap(message.data()))
        .toList());
  }

  @override
  Future<bool> saveMessage(
      Message currentMessage, UserModel fromUser, UserModel toUser) async {
    String _messageID = _firebase.collection("chats").doc().id;
    String _myDocumentID = currentMessage.fromID + "--" + currentMessage.toID;
    String _receiverDocumentID =
        currentMessage.toID + "--" + currentMessage.fromID;
    currentMessage.messageID = _messageID;
    var _saveMessage = currentMessage.toMap();

    await _firebase
        .collection("chats")
        .doc(_myDocumentID)
        .collection("messages")
        .doc(_messageID)
        .set(_saveMessage);

    _saveMessage.update("fromMe", (value) => false);

    await _firebase
        .collection("chats")
        .doc(_receiverDocumentID)
        .collection("messages")
        .doc(_messageID)
        .set(_saveMessage);

    Chats _chats = Chats(
      fromUser: currentMessage.fromID,
      toUser: currentMessage.toID,
      lastMessage: currentMessage.message,
      seen: false,
      receiverUsername: toUser.userName,
      receiverPhotoUrl: toUser.profilUrl,
    );

    await _firebase.collection("chats").doc(_myDocumentID).set(_chats.toMap());

    _chats.fromUser = currentMessage.toID;
    _chats.toUser = currentMessage.fromID;
    _chats.receiverUsername = fromUser.userName;
    _chats.receiverPhotoUrl = fromUser.profilUrl;

    await _firebase
        .collection("chats")
        .doc(_receiverDocumentID)
        .set(_chats.toMap());
    return true;
  }

  @override
  Future<bool> deleteMessages(
      String fromUserID, String toUserID, List messageList) async {
    String _myDocumentID = fromUserID + "--" + toUserID;
    for (var currentMessageID in messageList) {
      await _firebase
          .collection("chats")
          .doc(_myDocumentID)
          .collection("messages")
          .doc(currentMessageID)
          .delete();
    }
    return true;
  }

  @override
  Future<DateTime> currentDate(String userID) async {
    await _firebase.collection("server").doc(userID).set({
      "clock": FieldValue.serverTimestamp(),
    });

    var clockMap = await _firebase.collection("server").doc(userID).get();
    Timestamp currentDate = await clockMap.data()["clock"];
    return currentDate.toDate();
  }

  @override
  Future<bool> saveToken(String userID, String token) {
    _firebase.doc("tokens/" + userID).set({"token": token});
  }

  @override
  Future<String> getToken(String userID) async {
    var _token = await _firebase.doc("tokens/" + userID).get();
    if (_token.data() == null) {
      return null;
    } else {
      return _token.data()["token"];
    }
  }

  @override
  Future<bool> changeUserOnline(String userID, bool online) async {
    await _firebase.collection("users").doc(userID).update({"online": online});
    if (online == false) {
      await _firebase
          .collection("users")
          .doc(userID)
          .update({"updateAt": FieldValue.serverTimestamp()});
    }
  }

  @override
  Stream<UserModel> getUserDetails(String userID) {
    var snapshot = _firebase.collection("users").doc(userID).snapshots();
    return snapshot.map((user) => UserModel.fromMap(user.data()));
  }

  @override
  Future<bool> changeWrite(
      UserModel fromUser, UserModel toUser, bool write) async {
    try {
      await _firebase
          .collection("chats")
          .doc(fromUser.userID + "--" + toUser.userID)
          .update({"write": write});
    } catch (e) {}
  }

  @override
  Stream<Chats> getChatDetails(UserModel fromUser, UserModel toUser) {
    var snapshot = _firebase
        .collection("chats")
        .doc(toUser.userID + "--" + fromUser.userID)
        .snapshots();
    return snapshot.map((user) => Chats.fromMap(user.data()));
  }

  Future<bool> sendPost(Post post) async {
    showLoading();
    String postID = _firebase.collection("posts").doc().id;
    post.postId = postID;
    await _firebase.collection("posts").doc(postID).set(post.toMap());
    dismissLoading();
    Get.back();
    return true;
  }

  @override
  Stream<List<Post>> getAllPost() {
    var snapshot = _firebase
        .collection("posts")
        .orderBy("date", descending: true)
        .snapshots();

    return snapshot.map((allPost) => allPost.docs.map((post) {
          return Post.fromMap(post.data());
        }).toList());
  }

  @override
  Future<bool> sendComment(
      Post post, Comment comment, UserModel currentUser) async {
    String commentID = _firebase.collection("posts").doc().id;
    comment.commentID = commentID;

    await _firebase.collection("posts").doc(comment.postID).update({
      'lastComment': comment.commentText,
      'lastUsername': comment.username,
    });
    await _firebase.collection("posts").doc(comment.postID).update({
      'comments': FieldValue.increment(1),
    });
    await _firebase
        .collection("posts")
        .doc(comment.postID)
        .collection("comments")
        .doc(commentID)
        .set(comment.toMap());
    return true;
  }

  @override
  Stream<List<Comment>> getComment(String postID) {
    var snapshot = _firebase
        .collection("posts")
        .doc(postID)
        .collection("comments")
        .orderBy("date", descending: true)
        .snapshots();
    return snapshot.map((allComment) => allComment.docs
        .map((comment) => Comment.fromMap(comment.data()))
        .toList());
  }

  @override
  Future<bool> sendLike(Post post, UserModel currentUser, Like like) async {
    await _firebase
        .collection("posts")
        .doc(like.postID)
        .collection("likes")
        .doc(like.userID)
        .set(like.toMap());

    await _firebase.collection("posts").doc(like.postID).update({
      'likes': FieldValue.increment(1),
    });
    return true;
  }

  @override
  Stream<bool> likeControl(String postID, String userID) {
    var snapshots = _firebase
        .collection("posts")
        .doc(postID)
        .collection("likes")
        .doc(userID)
        .snapshots();
    return snapshots.map((event) => event.exists);
  }

  @override
  Future<bool> sendDislike(String postID, String userID) async {
    await _firebase
        .collection("posts")
        .doc(postID)
        .collection("likes")
        .doc(userID)
        .delete();
    await _firebase.collection("posts").doc(postID).update({
      'likes': FieldValue.increment(-1),
    });
    return true;
  }

  @override
  Stream<List<Like>> getAllLikes(String postID) {
    var snapshot = _firebase
        .collection("posts")
        .doc(postID)
        .collection("likes")
        .snapshots();
    return snapshot.map((allLike) =>
        allLike.docs.map((like) => Like.fromMap(like.data())).toList());
  }

  @override
  Future<bool> seenMessage(
      UserModel fromUser, UserModel toUser, String messageID) async {
    await _firebase
        .collection("chats")
        .doc(toUser.userID + "--" + fromUser.userID)
        .collection("messages")
        .doc(messageID)
        .update({"seen": "2"});
    return true;
  }

  @override
  Future<bool> clickSeenMessage(UserModel fromUser, UserModel toUser) async {
    var _querySnapshot = await _firebase
        .collection("chats")
        .doc(toUser.userID + "--" + fromUser.userID)
        .collection("messages")
        .where("fromMe", isEqualTo: true)
        .where("seen", isEqualTo: "1")
        .get();
    if (_querySnapshot.docs.isNotEmpty) {
      await _querySnapshot.docs[0].reference.update({"seen": "2"});
    }
    return true;
  }

  @override
  Stream<List<Message>> getAllNewMessage(String fromUserID, String toUserID) {
    var snapshot = _firebase
        .collection("chats")
        .doc(toUserID + "--" + fromUserID)
        .collection("messages")
        .where("fromMe", isEqualTo: true)
        .where("seen", isEqualTo: "1")
        .snapshots();
    return snapshot.map((messageList) => messageList.docs
        .map((message) => Message.fromMap(message.data()))
        .toList());
  }

  @override
  Future<bool> updateProfilePhoto(String userID, String photoUrl) async {
    await _firebase.collection("users").doc(userID).update({
      'profilUrl': photoUrl,
    });
  }

  @override
  Future<bool> deletePost(String postID) async {
    await _firebase.collection("posts").doc(postID).delete();
    return true;
  }
}
