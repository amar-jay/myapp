// flutter drawer component
import 'package:flutter/material.dart';
import 'package:myapp/pages/about.dart';
// import 'package:myapp/pages/chat_page.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/pages/weather_page.dart';
import 'package:myapp/pages/qrcode_page.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const pages = {
  'Home': HomePage(),
  'QrCode': QrcodePage(),
  // 'Chat': ChatPage(),
  'Settings': SettingsPage(),
  'Weather': WeatherPage(),
  'About': AboutPage(),
};

const pagesIcons = {
  'Home': Icons.home,
  'Chat': Icons.chat,
  'Settings': Icons.settings,
  'Weather': Icons.cloud,
  'About': Icons.info,
};

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    
    // drawer content: logo, homepage, chatpage, settingspage, weatherpage
    // at the bottom of drawer: logout button
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[ 
              Icon(
            Icons.air_sharp,
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text('FirstFlutter ', style: theme.textTheme.h1),
          ]),
        ), 

        ...pages.entries.map((e) => Column(
          children: [ListTile(
          title: Text(e.key),
          leading: Icon(pagesIcons[e.key], color: theme.colorScheme.primary),
          onTap: () {
            //Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => e.value));
          },
        ),
        ],
        )
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        const SizedBox(height: 20),

        // logout button
        ShadButton.outline(
          // place it at the bottom 
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24),

          onPressed: () {
              final auth = AuthService();
              auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
            }, 
          text: const Text('Log out'),
          icon: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.logout),
          ),
      )
      ],
      ),
    );
  }
}