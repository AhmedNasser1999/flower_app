import 'package:injectable/injectable.dart';

import '../repositories/address_repository.dart';
import '../requests/address_request.dart';
import '../responses/address_response.dart';

@injectable
class AddAddressUseCase {
  final AddressRepository repository;

  AddAddressUseCase({required this.repository});

  Future<AddressResponse> execute(AddressRequest addressRequest) async {
    return await repository.addAddress(addressRequest);
  }
}

@injectable
class GetAddressesUseCase {
  final AddressRepository repository;

  GetAddressesUseCase({required this.repository});

  Future<AddressResponse> execute() async {
    return await repository.getAddresses();
  }
}

@injectable
class UpdateAddressUseCase {
  final AddressRepository repository;

  UpdateAddressUseCase({required this.repository});

  Future<AddressResponse> execute(
      String id, AddressRequest addressRequest) async {
    return await repository.updateAddress(id, addressRequest);
  }
}

@injectable
class DeleteAddressUseCase {
  final AddressRepository repository;

  DeleteAddressUseCase({required this.repository});

  Future<AddressResponse> execute(String id) async {
    return await repository.deleteAddress(id);
  }
}
