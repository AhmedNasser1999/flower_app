import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/address.dart';
import '../../domain/requests/address_request.dart';
import '../../domain/responses/address_response.dart';
import '../../domain/use_cases/address_use_cases.dart';

part 'address_state.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  final AddAddressUseCase addAddressUseCase;
  final GetAddressesUseCase getAddressesUseCase;
  final UpdateAddressUseCase updateAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  String? selectedAddressId;

  AddressCubit({
    required this.addAddressUseCase,
    required this.getAddressesUseCase,
    required this.updateAddressUseCase,
    required this.deleteAddressUseCase,
  }) : super(AddressInitial());

  Future<void> addAddress(AddressRequest addressRequest) async {
    emit(AddressLoading());
    try {
      final response = await addAddressUseCase.execute(addressRequest);
      final updatedAddresses = await getAddressesUseCase.execute();
      emit(AddressLoaded(updatedAddresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> getAddresses() async {
    emit(AddressLoading());
    try {
      final response = await getAddressesUseCase.execute();
      safeEmit(AddressLoaded(response));
    } catch (e) {
      safeEmit(AddressError(e.toString()));
    }
  }

  Future<void> updateAddress(String id, AddressRequest addressRequest) async {
    safeEmit(AddressLoading());
    try {
      final response = await updateAddressUseCase.execute(id, addressRequest);
      final updatedAddresses = await getAddressesUseCase.execute();
      safeEmit(AddressLoaded(updatedAddresses));
      await getAddresses();
    } catch (e) {
      safeEmit(AddressError(e.toString()));
    }
  }

  Future<void> deleteAddress(String id) async {
    emit(AddressLoading());
    try {
      final response = await deleteAddressUseCase.execute(id);
      final updatedAddresses = await getAddressesUseCase.execute();
      emit(AddressLoaded(updatedAddresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  void selectAddress(String addressId) {
    selectedAddressId = addressId;

    if (state is AddressLoaded) {
      emit(AddressLoaded((state as AddressLoaded).response));
    }
  }

  Address? get selectedAddress {
    if (state is AddressLoaded && selectedAddressId != null) {
      final addresses = (state as AddressLoaded).response.addresses;
      return addresses.firstWhere(
        (addr) => addr.id == selectedAddressId,
      );
    }
    return null;
  }

  bool isSelected(String addressId) {
    return selectedAddressId == addressId;
  }

  void safeEmit(AddressState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
