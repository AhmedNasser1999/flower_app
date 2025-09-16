import 'package:dio/dio.dart';
import 'package:flower_app/features/address/api/client/address_api_client.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_source/address_remote_data_source.dart';

@Injectable(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final AddressApiClient addressApiClient;

  AddressRemoteDataSourceImpl({required this.addressApiClient});

  @override
  Future<AddressResponse> addAddress(AddressRequest addressRequest) async {
    try {
      final response = await addressApiClient.addAddress(addressRequest);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Server error: ${e.response!.statusCode} - ${e.response!.data}');
      } else {
        throw Exception('Network error: $e');
      }
    } catch (e) {
      throw Exception('Failed to create address: $e');
    }
  }

  @override
  Future<AddressResponse> getAddresses() async {
    try {
      final response = await addressApiClient.getAddresses();
      return response;
    } catch (e) {
      throw Exception('Failed to get addresses: $e');
    }
  }

  @override
  Future<AddressResponse> updateAddress(
      String id, AddressRequest addressRequest) async {
    try {
      final response = await addressApiClient.updateAddress(id, addressRequest);
      return response;
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  @override
  Future<AddressResponse> deleteAddress(String id) async {
    try {
      final response = await addressApiClient.deleteAddress(id);
      return response;
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }
}
