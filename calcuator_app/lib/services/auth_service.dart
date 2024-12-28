import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth change user stream
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with email & password
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
    // Register with email & password
  Future<UserCredential?> registerWithEmailPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
   // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}