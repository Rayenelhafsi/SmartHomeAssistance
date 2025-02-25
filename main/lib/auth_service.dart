import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Define _auth here
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '42087615644-rjgial203fibg558d0mch63i0kv7g7vn.apps.googleusercontent.com', // Updated with actual client ID
  );

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
    String password,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> enableMultiFactorAuth() async {
    // Implementation for enabling multi-factor authentication
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    // Implementation for verifying phone number
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges(); // Ensure _auth is used correctly
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(
          credential,
        );
        final User? user = authResult.user;

        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
