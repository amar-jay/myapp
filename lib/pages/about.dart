import 'package:flutter/material.dart';
import 'package:myapp/components/drawer.dart';

class AboutPage extends StatelessWidget {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1060000237.
  const AboutPage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),

      drawer: const DrawerComponent(),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text('A simple chat and weather app for my preparation to an internship at Remora',
        style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}