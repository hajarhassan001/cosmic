import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic/features/home/data/models/planet_model.dart';

class FirebaseHomeService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addDataToHome() async {
    final List<Map<String, dynamic>> planets = [
      {
        "name": "Mercury",
        "info":
            "Mercury is the smallest planet in the Solar System and the closest to the Sun. It has no natural satellites and a very thin atmosphere, composed mainly of oxygen, sodium, hydrogen, helium, and potassium. Mercury's surface is heavily cratered and similar in appearance to the Moon, indicating that it has been geologically inactive for billions of years. Due to its proximity to the Sun, temperatures on Mercury's surface vary drastically between scorching hot during the day and freezing cold at night.",
        "image": "https://link-to-mercury.jpg",
        "order": 1,
      },
      {
        "name": "Venus",
        "info":
            "Venus is the second planet from the Sun and is often called Earth's 'sister planet' due to their similar size and mass. However, Venus has an extremely dense atmosphere composed mostly of carbon dioxide, with clouds of sulfuric acid, making it the hottest planet in the Solar System. The surface temperature is hot enough to melt lead. Venus rotates very slowly and in the opposite direction to most planets, meaning the Sun rises in the west and sets in the east.",
        "image": "https://link-to-venus.jpg",
        "order": 2,
      },
      {
        "name": "Earth",
        "info":
            "Earth is the third planet from the Sun and the only known celestial body to support life. About 71% of Earth's surface is covered with water, and its atmosphere, rich in nitrogen and oxygen, sustains diverse ecosystems. Earth has one natural satellite, the Moon, which influences tides and stabilizes the planet's axial tilt. Its magnetic field and atmosphere protect life from harmful solar radiation and meteoroids.",
        "image": "https://link-to-earth.jpg",
        "order": 3,
      },
      {
        "name": "Mars",
        "info":
            "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, only being larger than Mercury. In the English language, Mars is named for the Roman god of war. It is often referred to as the 'Red Planet' because of the iron oxide prevalent on its surface, which gives it a reddish appearance. Mars has a thin atmosphere, composed mostly of carbon dioxide, and surface features both reminiscent of the Moon and Earth. It has valleys, deserts, and polar ice caps. Mars hosts the tallest volcano in the Solar System, Olympus Mons, and one of the largest canyons, Valles Marineris. Scientists are especially interested in Mars because of evidence suggesting that liquid water once flowed on its surface and the possibility of past or present life.",
        "image": "https://link-to-mars.jpg",
        "order": 4,
      },
      {
        "name": "Jupiter",
        "info":
            "Jupiter is the largest planet in the Solar System, a gas giant primarily composed of hydrogen and helium. It has a powerful magnetic field and at least 95 known moons, including the four large Galilean moons: Io, Europa, Ganymede, and Callisto. Jupiter is famous for its Great Red Spot, a giant storm that has been raging for centuries. Its rapid rotation causes it to have a flattened shape and intense atmospheric bands.",
        "image": "https://link-to-jupiter.jpg",
        "order": 5,
      },
      {
        "name": "Saturn",
        "info":
            "Saturn is the sixth planet from the Sun and the second-largest in the Solar System. It is most recognizable for its extensive and bright ring system made of ice and rock particles. Like Jupiter, Saturn is a gas giant composed mainly of hydrogen and helium. It has more than 145 confirmed moons, with Titan being the largest and notable for its thick atmosphere and liquid methane lakes.",
        "image": "https://link-to-saturn.jpg",
        "order": 6,
      },
      {
        "name": "Uranus",
        "info":
            "Uranus is the seventh planet from the Sun and is classified as an ice giant. It has a unique sideways rotation, with its axis tilted more than 90 degrees, likely due to a massive collision. Uranus appears blue-green due to methane in its atmosphere, which absorbs red light. It has faint rings and at least 27 known moons, named mostly after characters from Shakespeare's plays.",
        "image": "https://link-to-uranus.jpg",
        "order": 7,
      },
      {
        "name": "Neptune",
        "info":
            "Neptune is the eighth and farthest known planet from the Sun in the Solar System. It is similar in composition to Uranus and is classified as an ice giant. Neptune is known for its deep blue color and supersonic winds, the fastest recorded in the Solar System. It has faint rings and 14 known moons, the largest being Triton, which has geysers of liquid nitrogen and is thought to be a captured Kuiper Belt object.",
        "image": "https://link-to-neptune.jpg",
        "order": 8,
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

  Future<PlanetModel> getPlanetByName(String name) async {
    final query = await _firestore
        .collection('planets')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw Exception("Planet not found");
    }

    final doc = query.docs.first;
    return PlanetModel.fromJson(doc.data(), doc.id);
  }
}
