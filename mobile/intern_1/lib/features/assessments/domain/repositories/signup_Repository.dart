import 'package:intern_1/features/auth/domain/entities/User_Entity.dart';

abstract class SignUpRepository {
  Future signUp({required UserEntity user});
}
