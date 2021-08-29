import 'package:get/get.dart';
import 'package:online_chat/controller/chat_controller.dart'; 

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
