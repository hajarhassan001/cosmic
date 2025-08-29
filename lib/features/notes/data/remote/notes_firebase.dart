import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(String planetName, String note) async {
    final user = FirebaseAuth.instance.currentUser!;

    await _firestore.collection('users').doc(user.uid).collection('notes').add({
      "planet": planetName,
      "note": note,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeNote(String userId, String noteId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .doc(noteId)
        .delete();
  }

  Future<List<Map<String, dynamic>>> loadNotes(String userId) async {
    final myNotes = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .orderBy("createdAt", descending: true)
        .get();

    return myNotes.docs.map((doc) {
      final data = doc.data();
      return {
        "id": doc.id,
        "planet": data["planet"],
        "note": data["note"],
        "createdAt": data["createdAt"],
      };
    }).toList();
  }
}
