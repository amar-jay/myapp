import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/chat_model.dart';
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

  Future<void> setUserLogIn(String userId, bool loggedIn) async {
    await _db.collection('users').doc(userId).update({'isLoggedIn': loggedIn});
  }


  // delete user
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }


  Future<void> addMessage(Message message) async {
    // sender id and reciever id cannot contain '_' bcs its the adjoint of ids
    if (message.senderId.contains('_') || message.recieverId.contains('_')) {
      throw Exception('Sender and reciever cannot contain _');
    }

    // if (message.senderId == message.recieverId) {
    //   throw Exception('Sender and reciever cannot be the same');
    // }

    List<String> ids = [message.senderId, message.recieverId];
    ids.sort();
    final chatId = ids.join('_');
    await _db.collection('chats').doc(chatId).collection('messages').add({
      'senderEmail': message.senderEmail,
      'message': message.message,
      'timestamp': message.timestamp.toIso8601String(),
    });
  }


  // checking all chatids that contain the user id
  Future<List<String>> getChatIds(String userId) async {
    final chatIds = await _db.collection('chats').get().then((chats)  {
      List<String> chatIds = [];
      for (var chat in chats.docs) {
        final chatId = chat.id;
        final chatMembers = chatId.split('_');
        if (chatMembers.contains(userId)) {
          chatIds.add(chatId);
        }
      }
      return chatIds;
    });


  return chatIds;
  }

  // get messages from chat
  Future<List<Message>> getMessages(String chatId) async {
    final messages = await _db.collection('chats').doc(chatId).collection('messages').get();
    return messages.docs.map((doc) => Message.fromJson(chatId, doc.data())).toList();
  }

}