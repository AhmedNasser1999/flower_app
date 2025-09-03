import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/contants/app_constants.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../../data/models/profile_response.dart';
import '../../data/models/upload_photo_response.dart';
part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) =>
      _ProfileApiClient(dio, baseUrl: baseUrl);

  @GET(AppConstants.profile)
  @Extra({'auth': true})
  Future<ProfileResponse> getProfile();

  @PUT(AppConstants.editProfile)
  @Extra({'auth': true})
  Future<EditProfileResponseModel> editProfile(@Body() EditProfileRequestModel model);

  @PUT(AppConstants.uploadPhoto)
  @MultiPart()
  @Extra({'auth': true})
  Future<UploadPhotoResponse> uploadPhoto(@Part(name: "photo") File photo);
}
