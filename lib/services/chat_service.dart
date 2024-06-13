import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user_model.dart' as user_model;

class ChatService {
  // initialize
  final _db = FirebaseFirestore.instance;

  // get all users
  Future<List<user_model.User>> getAllUsers() async {

    final events = await _db.collection('users').get();
    return events.docs.map((doc)=> user_model.User.fromJson(doc.data())).toList();
  }


  // add user
  Future<void> addUser(user_model.User user) async {
    await _db.collection('users').doc(user.id).set(user.toJson());
  }
  // check if user exists
  Future<bool> isUser(String id) async {
    final user = await _db.collection('users').doc(id).get();
    return user.exists;
  }


  // delete user
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }

  //
}