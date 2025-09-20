import 'package:flower_app/features/occasion/api/client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/data/datasource/occasion_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../../data/models/occasion_response_model.dart';

@Injectable(as: OccasionRemoteDataSource)
class OccasionRemoteDataSourceImpl implements OccasionRemoteDataSource {
  final ApiClient _apiClient;

  OccasionRemoteDataSourceImpl(this._apiClient);

  @override
  Future<OccasionsResponse> getOccasions({int? page, int? limit}) async {
    try {
      return await _apiClient.getOccasions(page: page, limit: limit);
    } catch (e) {
      throw Exception('Failed to fetch occasions: $e');
    }
  }
}
