import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:myapp/models/user_model.dart' as user_model;

class AuthService {
  // initialize
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService chatService  = ChatService();

  // sign in
  Future<UserCredential> signIn(String email, String password) async {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // store user in firestore
      if (userCredential.user == null) {
        throw Exception('User is null');
      }

      // check if user exists if not add user
      // hmmm, is this the most resonable way to do this?
      // perhaps user, may be added on the backend if there is one
        if (!(await chatService.isUser(userCredential.user!.uid))){
          await chatService.addUser(user_model.User(id: userCredential.user!.uid, name: userCredential.user!.displayName??'Unknown', email: userCredential.user!.email!, isLoggedIn: true));
        }else {
          await chatService.setUserLogIn(userCredential.user!.uid, true);
        }

        return userCredential;
  }

  // get current user
  Future<user_model.User> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is null');
    }
    return user_model.User(id: user.uid, name: user.displayName??'Unknown', email: user.email!, isLoggedIn: true);
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
        await chatService.addUser(user_model.User(id: user.uid, name: user.displayName ?? "Unknown", email: user.email!, isLoggedIn: true));
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  } 
  // sign out
  Future<void> signOut() async {
    if (_auth.currentUser == null) {
      return;
    }
    await chatService.setUserLogIn(_auth.currentUser!.uid, false);
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