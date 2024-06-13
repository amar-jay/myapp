// flutter drawer component
import 'package:flutter/material.dart';
import 'package:myapp/pages/chat_page.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/pages/weather_page.dart';

const pages = {
  'Home': HomePage(),
  'Chat': ChatPage(),
  'Settings': SettingsPage(),
  'Weather': WeatherPage(),
};

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // drawer content: logo, homepage, chatpage, settingspage, weatherpage
    // at the bottom of drawer: logout button
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [DrawerHeader(
          child: Row(
            children:[ 
              const Text('FirstFlutter '),
              Icon(
            Icons.air_sharp,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          )]),
        ), 
        const SizedBox(height: 10),
        ...pages.entries.map((e) => Text('${e.key} -- ${e.value}'))],
        ),

    );
  }
}