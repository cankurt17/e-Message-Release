import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/chats.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart'; 
import 'package:timeago/timeago.dart' as timeago;

class ChatController extends GetxController {
  final UserModel fromUser = Get.arguments[0];
  final UserModel toUser = Get.arguments[1];
  final ScrollController scrollController = ScrollController();
  var _focus = false.obs;

  var _progress = 0.0.obs;

  var _imageFile = (null as File).obs;
  UserRepository _userRepository = UserRepository();
  TextEditingController messageTextController = TextEditingController();

  var _deleteMod = false.obs;
  RxList _radioList = [].obs;
  List deleteMessageIdList;

  get progress => this._progress.value;

  set progress(var value) => this._progress.value = value;

  var _loadingPhoto = false.obs;

  get loadingPhoto => this._loadingPhoto.value;

  set loadingPhoto(var loadingPhoto) => this._loadingPhoto.value = loadingPhoto;

  get imageFile => this._imageFile.value;

  set imageFile(value) => this._imageFile.value = value;

  get focus => this._focus.value;

  set focus(var value) => this._focus.value = value;

  var _chatResultIcon = Icons.schedule;

  get chatResultIcon => this._chatResultIcon;

  set chatResultIcon(var value) => this._chatResultIcon = value;

  get radioList => this._radioList;

  set radioList(var value) => this._radioList.value = value;

  get deleteMod => this._deleteMod.value;

  set deleteMod(var value) => this._deleteMod.value = value;

  @override
  void onReady() {
    Get.find<HomeController>().selectedNavBarIndex = 3;
    super.onReady();
  }

  Stream<List<Message>> getMessages() {
    return _userRepository.getMessages(fromUser.userID, toUser.userID);
  }

  void sendMessage({String type}) async {
    if (messageTextController.text.length > 0 || type != "str") {
      String imgUrl;
      if (type == "photo") {
        messageTextController.clear();
        if (imageFile != null) {
          loadingPhoto = true;
          imgUrl = await _userRepository.uploadFile(fromUser.userID, "messages",
              imageFile, DateTime.now().toString() + ".png", listenUploadTask);
          loadingPhoto = false;
          imageFile = null;
          Get.back();
        }
      }
      Message currentMessage = Message(
        fromID: fromUser.userID,
        toID: toUser.userID,
        fromMe: true,
        type: type,
        photo: imgUrl,
        message: messageTextController.text,
      );

      messageTextController.clear();
      var result =
          await _userRepository.saveMessage(currentMessage, fromUser, toUser);

      if (result == true) {
        scrollController.animateTo(
          0.0,
          duration: new Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    }
  }

  String getHourAdnMinute(DateTime date) {
    var _formatter = DateFormat.Hm();
    return _formatter.format(date);
  }

  void setDeleteMod(bool mod) {
    deleteMod = mod;
    clearRadioList();
  }

  void selectedDeleteMessage(int index, String messageID) {
    if (radioList[index] == "") {
      radioList[index] = messageID.toString();
      deleteMessageIdList.add(messageID);
    } else {
      radioList[index] = "";
      deleteMessageIdList.remove(messageID);
    }
  }

  void deleteMessage() async {
    await _userRepository.deleteMessages(
        fromUser.userID, toUser.userID, deleteMessageIdList);
    clearRadioList();
  }

  void clearRadioList() {
    for (var i = 0; i < radioList.length - 1; i++) {
      radioList[i] = "";
    }
    deleteMessageIdList = [];
  }

  IconData getChatIcon(Message message) {
    if (message.date == null) {
      return Icons.schedule;
    } else if (message.seen == "1") {
      return Icons.done;
    } else if (message.seen == "2") {
      return Icons.done_all;
    }
  }

  Stream<UserModel> getUserDetails() {
    return _userRepository.getUserDetails(toUser.userID);
  }

  String currentDate(UserModel user, DateTime createDate, DateTime dateTime,
      Chats chatDetail) {
    if (user.online) {
      if (chatDetail.write) {
        return "Yazıyor...";
      } else {
        return "Çevrimiçi";
      }
    } else {
      var _duration = dateTime.difference(createDate);
      timeago.setLocaleMessages('tr', timeago.TrMessages());
      String differenceDate =
          timeago.format(dateTime.subtract(_duration), locale: "tr");
      return differenceDate;
    }
  }

  Stream<Chats> getChatDetails() {
    return _userRepository.getChatDetails(fromUser, toUser);
  }

  Future<void> changeWrite() async {
    _userRepository.changeWrite(fromUser, toUser, true);
    String message = messageTextController.text;
    await Future.delayed(Duration(seconds: 2));
    if (message == messageTextController.text) {
      _userRepository.changeWrite(fromUser, toUser, false);
    }
  }

  Future seenMessage(String messageID) async {
    await _userRepository.seenMessage(fromUser, toUser, messageID);
  }

  Future connectGallery() async {
    var _img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    imageFile = File(_img.path);
    print(_imageFile);
  }

  listenUploadTask(TaskSnapshot event) {
    print(event.bytesTransferred.toDouble());
    print(event.totalBytes.toDouble());
    progress =
        (event.bytesTransferred.toDouble()) / event.totalBytes.toDouble();
  }

  Future connectCamera() async {
    var _img = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    imageFile = File(_img.path);
    print(_imageFile);
  }
}
