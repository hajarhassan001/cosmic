import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic/features/home/data/models/planet_model.dart';

class FirebaseHomeService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addDataToHome() async {
    final List<Map<String, dynamic>> planets = [
      {
        "name": "Mercury",
        "info":
            "Mercury is the smallest planet in the Solar System and the closest to the Sun. It has no natural satellites and a very thin atmosphere.",
        "image": "https://link-to-mercury.jpg",
        "order": 1,
        "mass": 0.33, // 10^24 kg
        "gravity": 3.7, // m/s²
        "day": 4222.6, // hours (≈176 Earth days)
        "velocity": 47.4, // km/s
        "temp": 167, // °C
        "distance": 57.9, // million km
      },
      {
        "name": "Venus",
        "info":
            "Venus is the second planet from the Sun. It has a dense CO₂ atmosphere and surface temperatures hot enough to melt lead.",
        "image": "https://link-to-venus.jpg",
        "order": 2,
        "mass": 4.87,
        "gravity": 8.9,
        "day": 2802, // hours (≈116 Earth days, retrograde)
        "velocity": 35.0,
        "temp": 464,
        "distance": 108.2,
      },
      {
        "name": "Earth",
        "info":
            "Earth is the third planet from the Sun and the only known celestial body to support life. About 71% of its surface is covered with water.",
        "image": "https://link-to-earth.jpg",
        "order": 3,
        "mass": 5.97,
        "gravity": 9.8,
        "day": 24,
        "velocity": 29.8,
        "temp": 15,
        "distance": 149.6,
      },
      {
        "name": "Mars",
        "info":
            "Mars is the fourth planet from the Sun, often called the Red Planet due to iron oxide dust. It has the largest volcano in the Solar System.",
        "image": "https://link-to-mars.jpg",
        "order": 4,
        "mass": 0.64,
        "gravity": 3.7,
        "day": 24.7,
        "velocity": 24.1,
        "temp": -65,
        "distance": 227.9,
      },
      {
        "name": "Jupiter",
        "info":
            "Jupiter is the largest planet in the Solar System, a gas giant with a strong magnetic field and dozens of moons.",
        "image": "https://link-to-jupiter.jpg",
        "order": 5,
        "mass": 1898,
        "gravity": 24.8,
        "day": 9.9,
        "velocity": 13.1,
        "temp": -110,
        "distance": 778.5,
      },
      {
        "name": "Saturn",
        "info":
            "Saturn is famous for its stunning rings, composed mainly of ice particles and rock debris.",
        "image": "https://link-to-saturn.jpg",
        "order": 6,
        "mass": 568,
        "gravity": 10.4,
        "day": 10.7,
        "velocity": 9.7,
        "temp": -140,
        "distance": 1434,
      },
      {
        "name": "Uranus",
        "info":
            "Uranus is an ice giant with a unique sideways rotation, likely caused by a massive collision in its past.",
        "image": "https://link-to-uranus.jpg",
        "order": 7,
        "mass": 86.8,
        "gravity": 8.7,
        "day": 17.2,
        "velocity": 6.8,
        "temp": -195,
        "distance": 2871,
      },
      {
        "name": "Neptune",
        "info":
            "Neptune is the farthest known planet from the Sun, famous for its deep blue color and supersonic winds.",
        "image": "https://link-to-neptune.jpg",
        "order": 8,
        "mass": 102,
        "gravity": 11.0,
        "day": 16.1,
        "velocity": 5.4,
        "temp": -200,
        "distance": 4495,
      },
    ];

    for (var planet in planets) {
      await _firestore
          .collection('planets')
          .doc(planet['name'].toString().toLowerCase())
          .set(planet);
    }

    print("✅ All planets uploaded successfully!");
  }

  // Future<PlanetModel> getPlanetByName(String name) async {
  //   final query = await _firestore
  //       .collection('planets')
  //       .where('name', isEqualTo: name)
  //       .limit(1)
  //       .get();

  //   if (query.docs.isEmpty) {
  //     throw Exception("Planet not found");
  //   }

  //   final doc = query.docs.first;
  //   return PlanetModel.fromJson(doc.data());
  // }

  Future<PlanetModel> getPlanetByName(String name) async {
    name = name.toLowerCase();
    final doc = await _firestore.collection('planets').doc(name).get();

    if (!doc.exists) {
      throw Exception("Planet not found");
    }

    return PlanetModel.fromJson(doc.data()!);
  }

  Future<PlanetModel> getPlanetOfTheDay() async {
    final query = await _firestore.collection('planets').orderBy('order').get();

    if (query.docs.isEmpty) {
      throw Exception("No planets found");
    }

    final day = DateTime.now().day;
    final index = (day - 1) % query.docs.length;

    final doc = query.docs[index];
    return PlanetModel.fromJson(doc.data());
  }
}
