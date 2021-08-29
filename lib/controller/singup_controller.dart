import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/animation/loading_dialog.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:online_chat/errors/signup_errors.dart';
import 'package:online_chat/ui/constants.dart';

class SingupController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  UserRepository _userRepository = UserRepository();
  var _passwordVisible = true.obs;

  get passwordVisible => this._passwordVisible.value;

  set passwordVisible(var passwordVisible) =>
      this._passwordVisible.value = passwordVisible;

  String emailValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-email';
      } else if (!emailValidate.hasMatch(value)) {
        throw 'email-validate';
      }
    } on String catch (e) {
      return signupError(e);
    } catch (e) {
      return signupError(e);
    }
  }

  String passwordValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-password';
      } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
        throw 'upper-case-password';
      } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
        throw 'lower-case-password';
      } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
        throw "number-password";
      } else if (!RegExp(r'.{8,}').hasMatch(value)) {
        throw "digit-password";
      } else
        return null;
    } on String catch (e) {
      return signupError(e);
    } catch (e) {
      return signupError(e);
    }
  }

  void createUserWithEmailandPassword() async {
    showLoading();
    if (formKey.currentState.validate()) {
      try {
        UserModel user = await _userRepository.createUserWithEmailandPassword(
            emailTextController.text, passwordTextController.text);
        if (user != null) {
          dismissLoading();
          Get.back();
          signupError('succes-auth');
        }
      } catch (e) {
        dismissLoading();
        signupError(e);
      }
    } else {
      dismissLoading();
    }
  }

  void currentUser() async {
    User user = await _userRepository.currentUser();
    print(user.email);
  }

  void changePasswordVisible() {
    passwordVisible = !passwordVisible;
  }
}
