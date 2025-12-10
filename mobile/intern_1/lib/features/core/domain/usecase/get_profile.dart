import 'package:intern_1/features/core/domain/repository/profile_repo.dart';

class GetProfile {
  final ProfileRepo repo;
  GetProfile(this.repo);

  Future<Map<String, dynamic>> call() {
    return repo.getProfile();
  }
}
