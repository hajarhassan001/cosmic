import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic/features/auth/model/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser> signUp(String name, String email, String password ) async {
    try {

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;

      AppUser appUser = AppUser(
        id: user.uid,
        name: name,
        email: email,
      );
      try {
        await _firestore.collection('users').doc(user.uid).set(appUser.toJson());
      } catch (e) {
        print("Firestore error: $e");
      }
      return appUser;
    } catch (e) {
      print("FirebaseAuth error: $e");
      rethrow;
    }
  }
    Future<AppUser> login( String email, String password ) async {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User user = result.user!; 
        DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
        AppUser appUser = AppUser.fromJson(snapshot.data() as Map<String, dynamic>);
        return appUser;
      } catch (e) {
        print("FirebaseAuth error: $e");
        rethrow;
      }
        }
        Future<void> logOut() async {
  await _auth.signOut();
}


}
