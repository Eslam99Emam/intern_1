
import 'package:intern_1/features/core/domain/entity/assessment_entity.dart';
import 'package:intern_1/features/core/domain/repository/get_history_repo.dart';

class GetHistory {
  final GetHistoryRepo repo;
  GetHistory(this.repo);

  Future<List<AttemptEntity>> call() => repo.getHistory();
}
