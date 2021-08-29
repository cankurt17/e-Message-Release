import 'package:get/get.dart';
import 'package:online_chat/controller/complete_login_controller.dart';

class CompleteLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteLoginController>(() => CompleteLoginController());
  }
}
