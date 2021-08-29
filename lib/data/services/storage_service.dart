import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:online_chat/data/services/base/storage_base.dart';

class StorageService extends StorageBase {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _reference;
  @override
  Future<String> uploadFile(String userID, String fileType, File file,
      String fileName, Function uploadFunction) async {
    _reference = await _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child(fileName);

    UploadTask uploadTask = _reference.putFile(file);

    uploadTask.snapshotEvents.listen(uploadFunction);
    var url = await (await uploadTask).ref.getDownloadURL();

    return url;
  }
}
