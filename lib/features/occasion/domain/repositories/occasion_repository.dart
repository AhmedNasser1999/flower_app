import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';

abstract class OccasionRepository {
  Future<List<OccasionEntity>> getOccasions({
    int? page,
    int? limit,
  });
}
