import 'package:flower_app/features/address/data/models/address.dart';

class AddressResponse {
  final String message;
  final List<Address> addresses;

  AddressResponse({
    required this.message,
    required this.addresses,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    final addressesData = json['address'] ?? json['addresses'];

    List<Address> addressesList = [];
    if (addressesData is List) {
      addressesList = addressesData.map((addressJson) {
        return Address.fromJson(addressJson);
      }).toList();
    }

    return AddressResponse(
      message: json['message'] ?? '',
      addresses: addressesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'address': addresses.map((address) => address.toJson()).toList(),
    };
  }
}
