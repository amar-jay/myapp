import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:myapp/models/user_model.dart' as user_model;

class AuthService {
  // initialize
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService chatService  = ChatService();

  // sign in
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // store user in firestore
      final user = userCredential.user;
      if (user == null) {
        throw Exception('User is null');
      }

      // check if user exists if not add user
      // hmmm, is this the most resonable way to do this?
      // perhaps user, may be added on the backend if there is one
      if (!(await chatService.isUser(user.uid))){
        await chatService.addUser(user_model.User(id: user.uid, name: user.displayName!, email: user.email!));
      }

      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }

  // register
  Future<UserCredential> register(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // store user in firestore
      final user = userCredential.user;
      if (user != null) {
        await chatService.addUser(user_model.User(id: user.uid, name: user.displayName!, email: user.email!));
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  } 
  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // sign out

  //... boooring....
  /* Firebase errors are in the format 
    Exception: [firebase_auth/invalid-email] The email address is badly formatted.
    split and take message only
  */
  String formatErrorMessage(String message) {
      List<String> parts = message.split("] ");
      if (parts.length >= 2) {
        message = parts[1];
      }
      return message;
  }
}