import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1060000237.
  const ChatPage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Message $index'),
          );
        },
      ),
    );
  }
}