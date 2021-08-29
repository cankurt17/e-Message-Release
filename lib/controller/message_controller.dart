import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/home_controller.dart';
import 'package:online_chat/data/models/chats.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageController extends GetxController {
  UserModel fromUser = Get.find<HomeController>().user;
  UserRepository _userRepository = UserRepository();

  Stream<List<Chats>> getAllChats() {
    return _userRepository.getAllChats(fromUser.userID);
  }

  Future<String> currentDate(Timestamp createDate, DateTime dateTime) async {
    var _duration = dateTime.difference(createDate.toDate());
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    String differenceDate =
        timeago.format(dateTime.subtract(_duration), locale: "tr");
    return differenceDate;
  }

  Future<DateTime> getDate() async {
    return await _userRepository.currentDate(fromUser.userID);
  }

  Future openChat(String toUserID) async {
    UserModel toUser = await _userRepository.readReceiverUser(toUserID);
    clickSeenMessage(toUser);
    Get.toNamed('/chat', arguments: [fromUser, toUser]);
  }

  Stream<List<Message>> getAllNewMessage(String toUserID) {
    return _userRepository.getAllNewMessage(fromUser.userID, toUserID);
  }

  Future clickSeenMessage(UserModel toUser) async {
    await _userRepository.clickSeenMessage(fromUser, toUser);
  }
}
