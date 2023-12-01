class LocationModel {
  final String? name;
  final double? lat;
  final double? lng;

  LocationModel({
    this.name,
    this.lat,
    this.lng,
  });

  LocationModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        lat = json['lat'],
        lng = json['lng'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'lat': lat,
        'lng': lng,
      };
}
