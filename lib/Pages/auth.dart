import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentuser => _firebaseAuth.currentUser;

  Stream <User?> get authStatechanges => _firebaseAuth.authStateChanges();

// Sign in with email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Failed to create user: $e");
      return null;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Registration error: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
     try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Sign-out error: $e");
    }
  }
}
