import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/data/models/user_model.dart';

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

  String? getUserId() {
    final UserDataModel? user = box.get(HiveKeys.userData);
    return user?.userId;
  }
}

class HiveKeys {
  static String isFirstRun = "isFirstRun";
  static String authVerificationId = "verificationId";
  static String resendToken = "resendToken";

  static String userData = "userData";
}
