import 'package:get/get.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/repository/user_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

class ToProfileController extends GetxController {
  String toUserID = Get.arguments;
  var _toUser = (null as UserModel).obs;

  UserRepository _userRepository = UserRepository();

  get toUser => this._toUser.value;

  set toUser(var value) => this._toUser.value = value;

  void readUser() async {
    toUser = await _userRepository.readReceiverUser(toUserID);
  }

  String currentDate(UserModel user, DateTime createDate, DateTime dateTime) {
    if (user.online) {
      return "Çevrimiçi";
    } else {
      var _duration = dateTime.difference(createDate);
      timeago.setLocaleMessages('tr', timeago.TrMessages());
      String differenceDate =
          timeago.format(dateTime.subtract(_duration), locale: "tr");
      return differenceDate;
    }
  }
}
