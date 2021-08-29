import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_chat/ui/constants.dart';

class UserModel {
  final String userID;
  String email;
  String userName;
  String phoneNumber;
  DateTime createdAt;
  DateTime updateAt;
  bool gender;
  String profilUrl;
  bool complete;
  String message;
  String article;
  String photo;
  bool online;
  bool write;

  UserModel({this.userID, this.email});
  UserModel.withPhone({this.userID, this.phoneNumber});
  UserModel.withFacebook(this.userID, this.email, this.profilUrl);
  UserModel.complete(
      {this.userID, this.userName, this.gender, this.profilUrl, this.complete});
  UserModel.fromLocalDB({this.userID, this.complete});
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updateAt': updateAt ?? FieldValue.serverTimestamp(),
      'gender': gender ?? false,
      'profilUrl': profilUrl ?? kDefaultProfilePhoto,
      'complete': complete ?? false,
      'message': message ?? "0",
      'article': article ?? "0",
      'photo': photo ?? "0",
      'online': online ?? false,
      'write': write ?? false,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        phoneNumber = map['phoneNumber'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updateAt = (map['updateAt'] as Timestamp).toDate(),
        gender = map['gender'],
        profilUrl = map['profilUrl'],
        complete = map['complete'],
        message = map['message'],
        article = map['article'],
        online = map['online'],
        write = map['write'],
        photo = map['photo'];

  @override
  String toString() {
    return 'UserModel(userID: $userID, email: $email, userName: $userName, phoneNumber: $phoneNumber, createdAt: $createdAt, updateAt: $updateAt, gender: $gender, profilUrl: $profilUrl, complete: $complete)';
  }
}
