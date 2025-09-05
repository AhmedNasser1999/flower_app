import '../../data/models/occasion_response_model.dart';

abstract class OccasionRemoteDataSource {
  Future<OccasionsResponse> getOccasions({
    int? page,
    int? limit,
  });
}