import 'package:get/get.dart'; 
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';

class UsersController extends GetxController {
  UserModel fromUser = Get.find<HomeController>().user;
  UserRepository _userRepository = UserRepository();

  Stream<List<UserModel>> getAllUsers() {
    return _userRepository.getAllUsers();
  }

  pressMessageButton(UserModel toUser) {
    Get.toNamed('/chat', arguments: [fromUser, toUser]);
  }
}
