
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';
import 'package:intern_1/features/attempts/domain/repositories/get_history_repo.dart';

class GetHistory {
  final GetHistoryRepo repo;
  GetHistory(this.repo);

  Future<List<AttemptEntity>> call() => repo.getHistory();
}
