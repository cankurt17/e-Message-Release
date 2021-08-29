import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_chat/data/models/chats.dart';
import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/data/models/like.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/data/models/post.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/services/auth_services.dart';
import 'package:online_chat/data/services/base/auth_base.dart';
import 'package:online_chat/data/services/firebase_helper.dart';
import 'package:online_chat/data/services/local_database.dart';
import 'package:online_chat/data/services/notification_service.dart';
import 'package:online_chat/data/services/storage_service.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

class UserRepository extends AuthBase
    implements FirebaseHelper, StorageService {
  FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  FirebaseHelper _firebase = FirebaseHelper();
  LocalDatabase _localDatabase = LocalDatabase();
  StorageService _storageService = StorageService();
  NotificationService _notificationService = NotificationService();
  static Map<String, String> _userTokenList = Map<String, String>();
  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      UserModel _user = await _firebaseAuthService
          .createUserWithEmailandPassword(email, password);
      if (_user != null) {
        await saveUser(_user);
        await sendEmailVerification(await currentUser());
        await signOut();
        return _user;
      } else {
        throw 'default-error-102';
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      deleteUser();
      throw e;
    }
  }

  @override
  Future<bool> saveUser(UserModel user) async {
    var _result = await _firebase.saveUser(user);
    return _result;
  }

  @override
  Future deleteUser() async {
    await _localDatabase.deleteUser();
    _firebaseAuthService.deleteUser();
  }

  @override
  Future<User> currentUser() async {
    return await _firebaseAuthService.currentUser();
  }

  @override
  Future<bool> signOut() async {
    var _result = await _firebaseAuthService.signOut();
    if (_result) {
      await _localDatabase.deleteUser();
      return true;
    } else {
      throw 'default-error-101';
    }
  }

  @override
  Future<bool> sendEmailVerification(User user) async {
    bool _result = await _firebase.sendEmailVerification(user);
    if (_result) {
      return true;
    } else {
      throw 'default-error-103';
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    UserModel user = await _firebaseAuthService.signInWithGoogle();
    return signIn(user);
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      UserModel _userModel = await _firebaseAuthService.signInWithFacebook();
      return signIn(_userModel);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      deleteUser();
      throw e;
    }
  }

  @override
  Future<void> signInWithPhone(
      String phoneNumber,
      Function verificationCompleted,
      Function sendMessage,
      Function timeOut,
      Function error) async {
    try {
      await _firebaseAuthService.signInWithPhone(
          phoneNumber, verificationCompleted, sendMessage, timeOut, error);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<UserModel> verifyOTP(String verificationId, String smsCode) async {
    try {
      UserModel _user =
          await _firebaseAuthService.verifyOTP(verificationId, smsCode);

      return await signIn(_user);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  @override
  Future<UserModel> readUser(String userID) async {
    UserModel _user = await _firebase.readUser(userID);
    await _localDatabase.saveUser(_user);
    return _user;
  }

  @override
  Future<UserModel> getUser(String userID) async {
    UserModel _user = await _firebase.readUser(userID);
    return _user;
  }

  Future<UserModel> readReceiverUser(String userID) async {
    return await _firebase.readUser(userID);
  }

  Future<UserModel> signIn(UserModel user) async {
    if (user != null) {
      await saveUser(user);
      UserModel _user = await readUser(user.userID);
      print(_user);
      await _localDatabase.saveUser(user);
      return _user;
    }
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String sifre) async {
    try {
      UserModel _user =
          await _firebaseAuthService.signInWithEmailandPassword(email, sifre);
      return signIn(_user);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on String catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> usernameControl(String username) async {
    bool _result = await _firebase.usernameControl(username);
    if (_result) {
      return true;
    } else {
      throw 'username-validate';
    }
  }

  @override
  Future<bool> completeUser(UserModel user) async {
    await _firebase.completeUser(user);
    return true;
  }

  @override
  Future<String> uploadFile(String userID, String fileType, File file,
      String fileName, Function uploadFunction) async {
    return await _storageService.uploadFile(
        userID, fileType, file, fileName, uploadFunction);
  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    return _firebase.getAllUsers();
  }

  @override
  Stream<List<Message>> getMessages(String fromUserID, String toUserID) {
    return _firebase.getMessages(fromUserID, toUserID);
  }

  @override
  Future<bool> saveMessage(
      Message currentMessage, UserModel fromUser, UserModel toUser) async {
    var result = await _firebase.saveMessage(currentMessage, fromUser, toUser);
    if (result) {
      String token = "";
      if (_userTokenList.containsKey(toUser.userID)) {
        token = _userTokenList[toUser.userID];
      } else {
        token = await getToken(toUser.userID);
        _userTokenList[toUser.userID] = token;
      }
      if (token != null) {
        await _notificationService.sendMessageNotification(
            currentMessage, fromUser, token);
      }
      return true;
    }
  }

  @override
  Future<bool> deleteMessages(
      String fromUserID, String toUserID, List messageList) async {
    await _firebase.deleteMessages(fromUserID, toUserID, messageList);
    return true;
  }

  @override
  Stream<List<Chats>> getAllChats(String fromUserID) {
    return _firebase.getAllChats(fromUserID);
  }

  @override
  Future<DateTime> currentDate(String userID) async {
    return await _firebase.currentDate(userID);
  }

  @override
  Future<bool> saveToken(String userID, String token) async {
    await _firebase.saveToken(userID, token);
  }

  @override
  Future<String> getToken(String userID) async {
    return await _firebase.getToken(userID);
  }

  @override
  Future<bool> changeUserOnline(String userID, bool online) async {
    await _firebase.changeUserOnline(userID, online);
    return true;
  }

  @override
  Stream<UserModel> getUserDetails(String userID) {
    return _firebase.getUserDetails(userID);
  }

  @override
  Future<bool> changeWrite(
      UserModel fromUser, UserModel toUser, bool write) async {
    await _firebase.changeWrite(fromUser, toUser, write);
  }

  @override
  Stream<Chats> getChatDetails(UserModel fromUser, UserModel toUser) {
    return _firebase.getChatDetails(fromUser, toUser);
  }

  @override
  Future<UserModel> createPhoneUser(PhoneAuthCredential credential) async {
    UserModel _user = await _firebaseAuthService.createPhoneUser(credential);

    return await signIn(_user);
  }

  @override
  Future<bool> seenMessage(
      UserModel fromUser, UserModel toUser, String messageID) async {
    await _firebase.seenMessage(fromUser, toUser, messageID);
    return true;
  }

  @override
  Future<bool> sendPost(Post post) async {
    await _firebase.sendPost(post);
    return true;
  }

  @override
  Stream<List<Post>> getAllPost() {
    return _firebase.getAllPost();
  }

  @override
  Future<bool> sendComment(
      Post post, Comment comment, UserModel currentUser) async {
    await _firebase.sendComment(post, comment, currentUser);

    if (currentUser.userID != post.userID) {
      String token = "";
      if (_userTokenList.containsKey(post.userID)) {
        token = _userTokenList[post.userID];
      } else {
        token = await getToken(post.userID);
        _userTokenList[post.userID] = token;
      }
      if (token != null) {
        await _notificationService.sendCommentNotification(
            comment, currentUser, token);
      }
    }
    return true;
  }

  @override
  Stream<List<Comment>> getComment(String postID) {
    return _firebase.getComment(postID);
  }

  @override
  Future<bool> sendLike(Post post, UserModel currentUser, Like like) async {
    await _firebase.sendLike(post, currentUser, like);

    if (currentUser.userID != post.userID) {
      String token = "";
      if (_userTokenList.containsKey(post.userID)) {
        token = _userTokenList[post.userID];
      } else {
        token = await getToken(post.userID);
        _userTokenList[post.userID] = token;
      }
      if (token != null) {
        await _notificationService.sendLikeNotification(
            like, currentUser, token);
      }
    }
    return true;
  }

  @override
  Stream<bool> likeControl(String postID, String userID) {
    return _firebase.likeControl(postID, userID);
  }

  @override
  Future<bool> sendDislike(String postID, String userID) async {
    await _firebase.sendDislike(postID, userID);
    return true;
  }

  @override
  Stream<List<Like>> getAllLikes(String postID) {
    return _firebase.getAllLikes(postID);
  }

  @override
  Stream<List<Message>> getAllNewMessage(String fromUserID, String toUserID) {
    return _firebase.getAllNewMessage(fromUserID, toUserID);
  }

  @override
  Future<bool> clickSeenMessage(UserModel fromUser, UserModel toUser) async {
    await _firebase.clickSeenMessage(fromUser, toUser);
  }

  @override
  Future<bool> updateProfilePhoto(String userID, String photoUrl) async {
    await _firebase.updateProfilePhoto(userID, photoUrl);
    return true;
  }

  @override
  Future<bool> deletePost(String postID) async {
    await _firebase.deletePost(postID);
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuthService.resetPassword(email);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }
}
