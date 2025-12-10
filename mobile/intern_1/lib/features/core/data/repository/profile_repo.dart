import 'package:intern_1/features/core/data/datasource/get_profile_datasource.dart';
import 'package:intern_1/features/core/domain/repository/profile_repo.dart';

class ProfileRepoIMPL extends ProfileRepo {
  GetProfileDataSource dataSource;
  ProfileRepoIMPL(this.dataSource);

  @override
  Future<Map<String, dynamic>> getProfile() async {
    return (await dataSource.getProfile())["data"];
  }
}
