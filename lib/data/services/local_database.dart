import 'package:get_storage/get_storage.dart';
import 'package:online_chat/data/models/user.dart';

class LocalDatabase {
  GetStorage _database = GetStorage('login_firebase');
  String _auth = "auth";
  Future saveUser(UserModel _user) async {
    await deleteUser();

    await _database
        .write(_auth, {'userID': _user.userID, 'complete': _user.complete});
  }

  Future deleteUser() async {
    await _database.write(_auth, null);
  }

  Future<UserModel> readUser() async {
    if (_database.hasData(_auth)) {
      var _userID = await _database.read(_auth)["userID"];
      var _complete = await _database.read(_auth)["complete"];
      return UserModel.fromLocalDB(
        userID: _userID,
        complete: _complete,
      );
    } else {
      return null;
    }
  }
}
