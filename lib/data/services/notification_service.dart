import 'package:online_chat/data/models/comment.dart';
import 'package:online_chat/data/models/like.dart';
import 'package:online_chat/data/models/message.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  String endUrl = "https://fcm.googleapis.com/fcm/send";
  String _firebaseKey =
      "AAAAEaeOCik:APA91bGlQnubEys6pmcCD5vPQEqyiMtDuiae6Z_e_s_uzt3KoIaiDIyJxkPCO1Et5MIYkevUrIi-FYL3LSHSKk1o1RnoW_SGnSTJPGVr4YycMfpDVIYhy_aUAweLjtBxa8q5UVPINqVR";
  Future<bool> sendMessageNotification(
      Message message, UserModel currentUser, String token) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$_firebaseKey"
    };

    print(currentUser);
    String json =
        '{"to":"$token","data":{"title":"${currentUser.userName}","body":"${message.message}","type":"message","userID":"${currentUser.userID}"}}';

    http.Response response =
        await http.post(Uri.parse(endUrl), headers: headers, body: json);
    if (response.statusCode == 200) {
      print("işlem başarılı");
    } else {
      print("İşlem başarısız" + response.statusCode.toString());
      print("jsonumuz:" + json);
    }
  }

  Future<bool> sendLikeNotification(
      Like like, UserModel currentUser, String token) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$_firebaseKey"
    };
 
    String json =
        '{"to":"$token","data":{"title":"Beğeni","body":"${like.username} senin gönderini beğendi.","type":"like","userID":"${currentUser.userID}"}}';

    http.Response response =
        await http.post(Uri.parse(endUrl), headers: headers, body: json);
    if (response.statusCode == 200) {
      print("işlem başarılı");
    } else {
      print("İşlem başarısız" + response.statusCode.toString());
      print("jsonumuz:" + json);
    }
  }

  
  Future<bool> sendCommentNotification(
      Comment comment, UserModel currentUser, String token) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$_firebaseKey"
    };
 
    String json =
        '{"to":"$token","data":{"title":"Yorum","body":"${comment.username} senin gönderine yorum yaptı.","type":"comment","userID":"${currentUser.userID}"}}';

    http.Response response =
        await http.post(Uri.parse(endUrl), headers: headers, body: json);
    if (response.statusCode == 200) {
      print("işlem başarılı");
    } else {
      print("İşlem başarısız" + response.statusCode.toString());
      print("jsonumuz:" + json);
    }
  }
}
