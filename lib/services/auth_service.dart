import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // initialize
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
  // register
  Future<UserCredential> Register(String email, String password) async {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:505930389.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4058371523.
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  } 
  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // sign out

  //... boooring....
}
