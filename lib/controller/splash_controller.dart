import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:online_chat/animation/loading_dialog.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:online_chat/data/services/local_database.dart';

class SplashController extends GetxController {
  UserRepository _userRepository = UserRepository();
  LocalDatabase _localDatabase = LocalDatabase();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(milliseconds: 500), () async {
      await userControl();
    });
  }

  Future<dynamic> userControl() async {
    try {
      UserModel _user = await _localDatabase.readUser(); 
      if (_user != null) {
        _user = await _userRepository.readUser(_user.userID);
        dismissLoading();
        if (_user.complete) {
          return Get.offAllNamed("/home", arguments: _user);
        } else {
          return Get.offAllNamed("/complete_login", arguments: _user);
        }
      } else {
        return Get.offAllNamed("/login");
      }
    } catch (e) {
      return Get.offAllNamed("/login");
    }
  }
}
