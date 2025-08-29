class PlanetModel {
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
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'info': info,
      'image': image,
      'order': order,
      'mass': mass,
      'gravity': gravity,
      'day': day,
      'velocity': velocity,
      'temp': temp,
      'distance': distance,
    };
  }

  factory PlanetModel.fromJson(Map<String, dynamic> json) {
    return PlanetModel(
      name: json['name'],
      info: json['info'],
      image: json['image'],
      order: json['order'],
      mass: (json['mass']),
      gravity: (json['gravity']),
      day: (json['day']),
      velocity: (json['velocity']),
      temp: (json['temp']),
      distance: (json['distance']),
    );
  }
}
