class Place {
  final double latitude;
  final double longitude;
  final String id;
  final String? name;
  final String? address;

  Place({
    required this.latitude,
    required this.longitude,
    required this.id,
    this.name,
    this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    latitude: json['latitude'] is double ? json['latitude'] : double.parse(json['latitude']),
    longitude: json['longitude'] is double ? json['longitude'] : double.parse(json['longitude']),
    id: json['id'],
    name: json['name'],
    address: json['address'],
  );
}
