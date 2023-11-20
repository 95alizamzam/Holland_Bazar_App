import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FireBaseStorageService {
  final storage = FirebaseStorage.instance;

  Future<String> getDownloadUrl(String path) async {
    return await storage.ref().child(path).getDownloadURL();
  }
}
