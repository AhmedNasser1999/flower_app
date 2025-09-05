// features/occasion/data/repositories/occasion_repository_impl.dart
import 'package:flower_app/features/occasion/data/datasource/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repository.dart';
import 'package:injectable/injectable.dart';

import '../models/occasion_model.dart';

@Injectable(as: OccasionRepository)
class OccasionRepositoryImpl implements OccasionRepository {
  final OccasionRemoteDataSource _remoteDataSource;

  OccasionRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<OccasionEntity>> getOccasions({int? page, int? limit}) async {
    try {
      final response = await _remoteDataSource.getOccasions(
          page: page,
          limit: limit
      );
      return _mapModelsToEntities(response.occasions);
    } catch (e) {
      throw Exception('Failed to get occasions: $e');
    }
  }

  List<OccasionEntity> _mapModelsToEntities(List<OccasionModel> models) {
    return models.map((model) => OccasionEntity(
      id: model.id,
      name: model.name,
      slug: model.slug,
      image: model.image,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      isSuperAdmin: model.isSuperAdmin,
      productsCount: model.productsCount,
    )).toList();
  }
}