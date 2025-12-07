import 'package:intern_1/features/auth/domain/entities/User_Entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.grade,
    required super.password,
  });
}
