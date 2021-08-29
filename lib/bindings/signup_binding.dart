import 'package:get/get.dart';
import 'package:online_chat/controller/singup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingupController>(() => SingupController() );
  }
}
