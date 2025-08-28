import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> loadFavourites(String userId) async {
    final myFavourites = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .get();

    return myFavourites.docs.map((doc) => doc.id).toList();
  }

  Future<void> addToFavourites(String userId, String planetName) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .doc(planetName)
        .set({});
  }

  Future<void> removeFromFavourites(String userId, String planetName) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .doc(planetName)
        .delete();
  }
}