import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService() {}

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uplOadUserPfp({
    required File file,
    required String uid,
  }) async {
    Reference fileRef = _firebaseStorage
        .ref('users/pfps')
        .child('$uid${p.extension(file.path)}');
    UploadTask task = fileRef.putFile(file);
    return task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
    });
  }
}
