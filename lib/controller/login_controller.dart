import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/animation/loading_dialog.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:online_chat/data/services/local_database.dart';
import 'package:online_chat/errors/login_errors.dart';
import 'package:online_chat/errors/signup_errors.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

enum enumPageView {
  emailForm,
  phoneForm,
  validateForm,
}

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  var _passwordVisible = true.obs;
  UserRepository _userRepository = UserRepository();
  LocalDatabase _localDatabase = LocalDatabase();
  var _pageViewIndex = 0.obs;
  String _verificationId = "";
  final pinPutController = TextEditingController();
  final pinPutFocusNode = FocusNode();
  bool _loginPhone = false;
  PageController pageViewController = PageController(initialPage: 0);
  TextEditingController phoneTextController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController forgotPasswordTextController = TextEditingController();

  get pageViewIndex => this._pageViewIndex.value;

  set pageViewIndex(var value) => this._pageViewIndex.value = value;

  get passwordVisible => this._passwordVisible.value;

  set passwordVisible(var passwordVisible) =>
      this._passwordVisible.value = passwordVisible;

  void changePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  void signInWithGoogle() async {
    showLoading();
    try {
      UserModel _user = await _userRepository.signInWithGoogle();
      if (_user != null) {
        signIn(_user);
      }
      dismissLoading();
    } catch (e) {
      print(e);
      dismissLoading();
      loginError(e);
    }
  }

  void signInWithFacebook() async {
    showLoading();
    try {
      UserModel _user = await _userRepository.signInWithFacebook();
      if (_user != null) {
        signIn(_user);
      }
      dismissLoading();
    } catch (e) {
      print(e.toString());
      dismissLoading();
      loginError(e);
    }
  }

  void signIn(UserModel user) {
    print(user);
    if (user.complete) {
      Get.offAllNamed("/home", arguments: user);
    } else {
      Get.offAllNamed("/complete_login", arguments: user);
    }
  }

  void signInWithEmailandPassword() async {
    try {
      if (loginFormKey.currentState.validate()) {
        showLoading();
        UserModel _user = await _userRepository.signInWithEmailandPassword(
            emailTextController.text, passwordTextController.text);

        if (_user != null) {
          dismissLoading();
          signIn(_user);
        }
        dismissLoading();
      }
    } catch (e) {
      dismissLoading();
      print(e);
      loginError(e);
    }
  }

  void signInWithPhone() async {
    if (formKey.currentState.validate()) {
      showLoading();
      try {
        var result = await _userRepository.signInWithPhone(
          phoneTextController.text,
          phoneVerificationComplete,
          phoneSendMessage,
          phoneTimeOut,
          phoneError,
        );
      } catch (e) {
        print("1");
        dismissLoading();
        loginError(e);
      }
    }
  }

  void phoneVerificationComplete(PhoneAuthCredential credential) async {
    try {
      showLoading();
      UserModel _user = await _userRepository.createPhoneUser(credential);
      dismissLoading();
      signIn(_user);
    } catch (e) {
      print("2");
      dismissLoading();
      print(e);
      loginError(e);
    }
  }

  void phoneSendMessage(String verificationId, int resendToken) async {
    try {
      dismissLoading();
      _verificationId = verificationId;
      changePageView(enumPageView.phoneForm);
    } catch (e) {
      print("3");
      dismissLoading();
      print(e);
      loginError(e);
    }
  }

  void verifyOTP() async {
    try {
      if (pinPutController.text.length == 6) {
        showLoading();
        UserModel _user = await _userRepository.verifyOTP(
            _verificationId, pinPutController.text);
        if (_user != null) {
          _loginPhone = true;
          dismissLoading();
          signIn(_user);
        }
        dismissLoading();
      } else {
        throw 'lenght-sms-code';
      }
    } catch (e) {
      print("4");
      dismissLoading();
      print(e);
      loginError(e);
    } finally {
      pinPutController.text = "";
    }
  }

  void phoneTimeOut(String verificationId) {
    if (_loginPhone == false) {
      loginError('sms-time-out');
      pageViewAnimation(1);
    }
  }

  void phoneError(FirebaseAuthException e) {
    print("5");
    print(e.code);
    dismissLoading();
    loginError(e);
  }

  void changePageView(enumPageView value) {
    switch (value) {
      case enumPageView.emailForm:
        if (pageViewController.page == 0) {
          pageViewIndex = 1;
          pageViewAnimation(1);
        } else {
          pageViewIndex = 0;
          pageViewAnimation(0);
        }
        break;
      case enumPageView.phoneForm:
        pageViewAnimation(2);
        break;
      case enumPageView.validateForm:
        break;
      default:
    }
  }

  void pageViewAnimation(int page) {
    pageViewController.animateToPage(page,
        duration: new Duration(seconds: 1), curve: Curves.easeInQuint);
  }

  String phoneNumberValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-phone-number';
      } else if (value.length != 10) {
        throw 'lenght-phone-number';
      } else if (!phoneNumberValidate.hasMatch(value)) {
        throw 'phone-number-validate';
      }
    } on String catch (e) {
      return loginError(e);
    }
  }

  String emailValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-email';
      }
    } on String catch (e) {
      return loginError(e);
    }
  }

  String passwordValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-password';
      }
    } on String catch (e) {
      return loginError(e);
    }
  }

  String forgotEmailValidator(String value) {
    try {
      if (value.isEmpty) {
        throw 'empty-email';
      } else if (!emailValidate.hasMatch(value)) {
        throw 'email-validate';
      } else {}
    } on String catch (e) {
      return signupError(e);
    } catch (e) {
      return signupError(e);
    }
  }

  void resetPassword() async {
    if (forgotFormKey.currentState.validate()) {
      try {
        await _userRepository.resetPassword(forgotPasswordTextController.text);
        Get.back();
        customSnackBar("Şifre yenileme başarılı.",
            "Mailinize gelen link ile birlikte şifrenizi yenileyebilirsiniz",
            icon: Icons.vpn_key, color: kPrimaryColor);
        emailTextController.clear();
      } on String catch (e) {
        loginError(e);
      } catch (e) {
        return loginError(e);
      }
    }
  }
}
