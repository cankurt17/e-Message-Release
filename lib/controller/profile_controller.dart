import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileController extends GetxController {
  UserModel fromUser = Get.find<HomeController>().user;
  File _imageFile;
  String _photoUrl;
  UserRepository _userRepository = UserRepository();

  var _profileImg = (null as FileImage).obs;

  get profileImg => this._profileImg.value;

  set profileImg(var value) => this._profileImg.value = value;

  String currentDate(
    UserModel user,
    DateTime createDate,
    DateTime dateTime,
  ) {
    if (user.online) {
      return "Çevrimiçi";
    } else {
      var _duration = dateTime.difference(createDate);
      timeago.setLocaleMessages('tr', timeago.TrMessages());
      String differenceDate =
          timeago.format(dateTime.subtract(_duration), locale: "tr");
      return differenceDate;
    }
  }

  Future imgFromGallery() async {
    var _img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    _imageFile = File(_img.path);
    profileImg = FileImage(_imageFile);
    if (_imageFile != null) {
      UploadTask uploadTask;
      _photoUrl = await _userRepository.uploadFile(fromUser.userID,
          "profile_photo", _imageFile, "profile_photo.png", null);
    }
    if (_photoUrl != null) {
      await _userRepository.updateProfilePhoto(fromUser.userID, _photoUrl);
    }
  }

  Future deletePost(String postID) async {
    await _userRepository.deletePost(postID);
  }
}
