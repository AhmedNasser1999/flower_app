class AddressRequest {
  final String? id;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String recipientName;
  final String? area;

  AddressRequest({
    this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.recipientName,
    this.area,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
      'username': recipientName,
      if (area != null) 'area': area,
    };
  }
}