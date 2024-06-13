import 'package:flutter/material.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }, icon: const Icon(Icons.settings)),
          IconButton(
            onPressed: () {
              final auth = AuthService();
              auth.signOut();
            }, 
            icon: const Icon(Icons.logout),
          ),
      ])
      );
  }
}