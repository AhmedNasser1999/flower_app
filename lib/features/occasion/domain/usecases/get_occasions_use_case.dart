import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final OccasionRepository _occasionRepository;

  GetOccasionsUseCase(this._occasionRepository);

  Future<List<OccasionEntity>> call({int? page, int? limit}) async {
    return await _occasionRepository.getOccasions(page: page, limit: limit);
  }
}