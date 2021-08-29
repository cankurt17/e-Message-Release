import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageID;
  final String fromID;
  final String toID;
  final bool fromMe;
  final String message;
  final Timestamp date;
  String seen;
  String photo;
  String type;

  Message(
      {this.messageID,
      this.fromID,
      this.toID,
      this.fromMe,
      this.message,
      this.date,
      this.type,
      this.photo,
      this.seen});

  Map<String, dynamic> toMap() {
    return {
      'messageID': messageID,
      'fromID': fromID,
      'toID': toID,
      'fromMe': fromMe,
      'message': message,
      'date': date ?? FieldValue.serverTimestamp(),
      'seen': seen ?? "1",
      'photo': photo,
      'type': type,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : messageID = map['messageID'],
        fromID = map['fromID'],
        toID = map['toID'],
        fromMe = map['fromMe'],
        message = map['message'],
        date = map['date'],
        type = map['type'],
        photo = map['photo'],
        seen = map['seen'];

  @override
  String toString() {
    return 'Message(messageID: $messageID,fromID: $fromID, toID: $toID, fromMe: $fromMe, message: $message, date: $date)';
  }
}
