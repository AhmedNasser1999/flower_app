import 'package:dio/dio.dart';
import 'package:flower_app/core/contants/app_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/requests/address_request.dart';
import '../../domain/responses/address_response.dart';

part 'address_api_client.g.dart';

@injectable
@RestApi()
abstract class AddressApiClient {
  @factoryMethod
  factory AddressApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) =
      _AddressApiClient;

  @PATCH(AppConstants.addresses)
  @Extra({'auth': true})
  Future<AddressResponse> addAddress(@Body() AddressRequest request);

  @GET(AppConstants.addresses)
  @Extra({'auth': true})
  Future<AddressResponse> getAddresses();

  @PATCH('${AppConstants.addresses}/{id}')
  @Extra({'auth': true})
  Future<AddressResponse> updateAddress(
      @Path('id') String id, @Body() AddressRequest request);

  @DELETE('${AppConstants.addresses}/{id}')
  @Extra({'auth': true})
  Future<AddressResponse> deleteAddress(@Path('id') String id);
}
