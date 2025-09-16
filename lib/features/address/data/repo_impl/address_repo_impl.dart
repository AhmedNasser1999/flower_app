import 'package:flower_app/features/address/data/data_source/address_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/address_repository.dart';
import '../../domain/requests/address_request.dart';
import '../../domain/responses/address_response.dart';

@Injectable(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AddressResponse> addAddress(AddressRequest addressRequest) async {
    return await remoteDataSource.addAddress(addressRequest);
  }

  @override
  Future<AddressResponse> getAddresses() async {
    return await remoteDataSource.getAddresses();
  }

  @override
  Future<AddressResponse> updateAddress(
      String id, AddressRequest addressRequest) async {
    return await remoteDataSource.updateAddress(id, addressRequest);
  }

  @override
  Future<AddressResponse> deleteAddress(String id) async {
    return await remoteDataSource.deleteAddress(id);
  }
}
