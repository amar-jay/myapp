import 'package:flutter/material.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';



class ChatPage extends StatefulWidget {
  final String id;
  const ChatPage(this.id, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ChatPage> createState() => _ChatPageState(id);
}

class _ChatPageState extends State<ChatPage> {
  final String id;
  final TextEditingController _messageController = TextEditingController();
  _ChatPageState(this.id);
  
  User? user;
  String chatId = '';
  List<Message> messages = [];

  _showToast(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  _fetchUserChats() async {

    final auth = AuthService(); 
    final u = await auth.getCurrentUser();
    setState(() {
      user = u;
    });
    List<String> ids = [id, user!.id];
    ids.sort();
    setState(() => chatId = ids.join('_'));
    final chatService = ChatService();
    final chats = await chatService.getMessages(chatId);
    setState(() {
      messages = chats;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      _fetchUserChats();
    } catch (e) {
      _showToast(context, e.toString());
    }
  }

  _sendMessage(TapDownDetails details) async {
    if (_messageController.text.isEmpty) {
      return;
    }
   final chatservice = ChatService();
     Message message = Message(
    senderEmail: user!.email,
    senderId: user!.id,
    recieverId: id,
    message: _messageController.text,
    timestamp: DateTime.now(),
    );

    await chatservice.addMessage(message);
    final chats = await chatservice.getMessages(chatId);
    setState(() {
      messages = chats;
    });
    return _messageController.clear();
  }


  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),

      // drawer: const DrawerComponent(),
      body: Column(
        children:[
          const Text("Chat, well not done. I dont know how to stream messages on Flutter, as well as I've no Idea how to have a stateful widget whilst simultaneously taking in an argument. Cannot trade one for another need both to funcion."),
          const SizedBox(height: 20),
          ShadInput(controller: _messageController, placeholder: const Text('Message'), suffix: ShadButton(text: const Text('Send'), onTapDown: _sendMessage,)),
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            // physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            reverse: true,
            scrollDirection: Axis.vertical,
            children: [
              ...messages.map(
                (message) => ListTile(
                  title: Text(message.message),
                  subtitle: Text(message.timestamp.toString()),
                ),
              )
            ],
            ),
      
        ],
      ),
    );
  }
}