class Address {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String id;
  final String? recipientName;
  final String? area;

  Address({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.id,
    this.recipientName,
    this.area,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      lat: json['lat'] ?? '',
      long: json['long'] ?? '',
      id: json['_id'] ?? '',
      recipientName: json['username'] ?? json['username'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
      'username': recipientName,
      '_id': id,
      if (area != null) 'area': area,
    };
  }
}
