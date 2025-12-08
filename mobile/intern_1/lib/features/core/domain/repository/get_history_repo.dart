import 'package:intern_1/features/core/domain/entity/assessment_entity.dart';

abstract class GetHistoryRepo {
  Future<List<AttemptEntity>> getHistory();
}
