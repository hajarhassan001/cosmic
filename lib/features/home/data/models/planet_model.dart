class PlanetModel {
  final String id;
  final String name;
  final String info;
  final String image;
  final int order;
  final double mass;
  final double gravity;
  final double day;
  final double velocity;
  final double temp;
  final double distance;

  PlanetModel({
    required this.id,
    required this.name,
    required this.info,
    required this.image,
    required this.order,
    required this.mass,
    required this.gravity,
    required this.day,
    required this.velocity,
    required this.temp,
    required this.distance,
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json, String id) {
    return PlanetModel(
      id: id,
      name: json['name'],
      info: json['info'],
      image: json['image'],
      order: json['order'],
      mass: (json['mass'] as num).toDouble(),
      gravity: (json['gravity'] as num).toDouble(),
      day: (json['day'] as num).toDouble(),
      velocity: (json['velocity'] as num).toDouble(),
      temp: (json['temp'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
    );
  }
}
