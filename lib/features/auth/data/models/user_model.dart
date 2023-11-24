import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 4)
class UserDataModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String? phoneNumber;
  @HiveField(2)
  final String? displayName;
  @HiveField(3)
  final String? refreshToken;
  UserDataModel({
    required this.userId,
    this.phoneNumber,
    this.displayName,
    this.refreshToken,
  });

  
}
