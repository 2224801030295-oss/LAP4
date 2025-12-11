class LocationModel {
  final double latitude;
  final double longitude;
  final String city;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'city': city,
  };
}
