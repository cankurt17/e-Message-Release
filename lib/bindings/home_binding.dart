import 'package:get/get.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/controller/message_controller.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/controller/profile_controller.dart';
import 'package:online_chat/controller/users_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController() );
    Get.lazyPut<MessageController>(() => MessageController() );
    Get.lazyPut<UsersController>(() => UsersController() );
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
