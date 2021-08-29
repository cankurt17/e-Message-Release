 
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageBase {
  Future<String> uploadFile(String userID,String fileType,File file,String fileName, Function uploadFunction );
}
