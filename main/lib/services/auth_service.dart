import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  AuthService() {
    _googleSignIn = GoogleSignIn(
      clientId:
          kIsWeb
              ? '42087615644-3nb23vgul9gmuojhe30ig9shgocdn198.apps.googleusercontent.com' // Web client ID
              : null, // Use default client ID for other platforms
    );
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("Google Sign-In canceled by user.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      // Extract username from email (part before @)
      final email = googleUser.email;
      final username = email?.split('@').first ?? 'user';

      // Update display name if not set
      if (userCredential.user?.displayName == null) {
        await userCredential.user?.updateDisplayName(username);
      }

      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendEmailVerification(User user) async {
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password, {
    String? displayName,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Set display name if provided
      if (displayName != null) {
        await userCredential.user?.updateDisplayName(displayName);
      }

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
