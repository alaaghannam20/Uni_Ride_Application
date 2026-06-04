class LocationModel {
  final int id;
  final String name;

  const LocationModel({required this.id, required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id:   (json['id'] ?? 0) as int,
      name: json['name'] ?? '',
    );
  }
}
