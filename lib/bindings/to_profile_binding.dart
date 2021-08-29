

import 'package:get/get.dart'; 
import 'package:online_chat/controller/to_profile_controller.dart'; 

class ToProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToProfileController>(() => ToProfileController());
  }
}
