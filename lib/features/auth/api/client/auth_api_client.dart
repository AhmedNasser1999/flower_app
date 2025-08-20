
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {

  @factoryMethod
  factory AuthApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _AuthApiClient;


}