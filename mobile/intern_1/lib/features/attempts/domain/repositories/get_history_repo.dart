import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';

abstract class GetHistoryRepo {
  Future<List<AttemptEntity>> getHistory();
}
