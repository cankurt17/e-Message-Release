import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_chat/animation/loading_dialog.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:online_chat/errors/complete_login_errors.dart';

class CompleteLoginController extends GetxController {
  final UserModel user = Get.arguments;
  UserRepository _userRepository = UserRepository();
  GlobalKey<FormState> usernameFormKey = GlobalKey<FormState>();
  PageController pageViewController = PageController(initialPage: 1);
  TextEditingController usernameTextController = TextEditingController();
  File _imageFile;
  String _photoUrl;
  var _profileImg = (null as FileImage).obs;
  var _selectedGender = "Erkek".obs;

  get selectedGender => this._selectedGender.value;

  set selectedGender(var value) => this._selectedGender.value = value;

  get profileImg => this._profileImg.value;

  set profileImg(var value) => this._profileImg.value = value;

  void contiunePageView() {
    switch (pageViewController.page.toInt()) {
      case 1:
        pageViewAnimation(2);
        break;
      case 2:
        pageViewAnimation(3);

        break;
      case 3:
        //_userRepository.signOut();
        //Get.offAllNamed("/login");

        updatePofile();
        break;
      default:
    }
  }

  void backPageView() {
    switch (pageViewController.page.toInt()) {
      case 2:
        pageViewAnimation(1);
        break;
      case 3:
        pageViewAnimation(2);
        break;
      default:
    }
  }

  void pageViewAnimation(int page) {
    pageViewController.animateToPage(page,
        duration: new Duration(seconds: 1), curve: Curves.easeInBack);
  }

  void imgFromGallery() async {
    var _img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    _imageFile = File(_img.path); 
    profileImg = FileImage(_imageFile);
  }

  String usernameValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-username';
      } else if (value.length < 3) {
        throw 'lenght-username';
      }
    } on String catch (e) {
      return completeLoginError(e);
    }
  }

  void changeGender(String value) {
    selectedGender = value;
  }

  void updatePofile() async {
    if (usernameFormKey.currentState.validate()) {
      showLoading();
      try {
        bool _result =
            await _userRepository.usernameControl(usernameTextController.text);
        if (_result) {
          if (_imageFile == null) {
            _photoUrl = user.profilUrl;
          } else {
            UploadTask uploadTask;
            _photoUrl = await _userRepository.uploadFile(
                user.userID, "profile_photo", _imageFile, "profile_photo.png",null);
          }

          UserModel _newUser = UserModel.complete(
              userID: user.userID,
              profilUrl: _photoUrl,
              userName: usernameTextController.text,
              gender: selectedGender == "Erkek" ? false : true,
              complete: true);
          await _userRepository.completeUser(_newUser);
          _newUser = await _userRepository.readUser(_newUser.userID);
          dismissLoading();
          print(_newUser);
          Get.offAllNamed("/home", arguments: _newUser);
        }
      } catch (e) {
        print(e);
        dismissLoading();
        completeLoginError(e);
      }
    }
  }
}
