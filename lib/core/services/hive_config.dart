import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveConfig {
  final String boxName = "tsc_box";
  late Box<dynamic> box;
  Future<void> init() async {
    box = await Hive.openBox('testBox');
  }

  Future<void> storeData({required String key, required dynamic value}) async {
    await box.put(key, value);
  }

  dynamic getData({required String key}) {
    return box.get(key);
  }
}

class HiveKeys {
  static String isFirstRun = "isFirstRun";
  static String authVerificationId = "verificationId";

  static String userId = "userId";
  static String userPhoneNumber = "userPhoneNumber";
  static String userName = "userName";
  static String userToken = "userToken";
}
