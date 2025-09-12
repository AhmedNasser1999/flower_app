import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';

abstract class AddressRemoteDataSource {
  Future<AddressResponse> addAddress(AddressRequest addressRequest);
  Future<AddressResponse> getAddresses();
  Future<AddressResponse> updateAddress(String id, AddressRequest addressRequest);
  Future<AddressResponse> deleteAddress(String id);
}