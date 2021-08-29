import 'package:cloud_firestore/cloud_firestore.dart';

class Chats {
  String fromUser;
  String toUser;
  final String lastMessage;
  final bool seen;
  final Timestamp createDate;
  final Timestamp seenDate;
  String receiverUsername;
  String receiverPhotoUrl; 
  String lastReadDate = "...";
  bool write;
  Chats(
      {this.fromUser,
      this.toUser,
      this.lastMessage,
      this.seen,
      this.createDate,
      this.seenDate,
      this.receiverUsername, 
      this.receiverPhotoUrl,
      this.write});

  Map<String, dynamic> toMap() {
    return {
      'fromUser': fromUser,
      'toUser': toUser,
      'lastMessage': lastMessage ?? "",
      'seen': seen, 
      'createDate': createDate ?? FieldValue.serverTimestamp(),
      'seenDate': seenDate,
      'receiverUsername': receiverUsername,
      'receiverPhotoUrl': receiverPhotoUrl,
      'write': write ?? false,
    };
  }

  Chats.fromMap(Map<String, dynamic> map)
      : fromUser = map['fromUser'],
        toUser = map['toUser'],
        lastMessage = map['lastMessage'],
        seen = map['seen'],
        createDate = map['createDate'],
        seenDate = map['seenDate'], 
        receiverUsername = map['receiverUsername'],
        receiverPhotoUrl = map['receiverPhotoUrl'],
        write = map['write'];

  @override
  String toString() {
    return 'Chats(fromUser: $fromUser, toUser: $toUser, lastMessage: $lastMessage, seen: $seen, createDate: $createDate, seenDate: $seenDate, receiverUsername: $receiverUsername, receiverPhotoUrl: $receiverPhotoUrl)';
  }
}
