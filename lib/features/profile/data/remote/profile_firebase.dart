import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loadName() async {
    final user = FirebaseAuth.instance.currentUser!;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc['name'] as String;
  }

  Future<void> updateName(String newName) async {
    final user = FirebaseAuth.instance.currentUser!;

    await _firestore.collection('users').doc(user.uid).set({
      "name": newName,
    }, SetOptions(merge: true));
  }
}
