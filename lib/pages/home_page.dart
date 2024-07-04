import 'package:flutter/material.dart';
import 'package:myapp/components/drawer.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/pages/about.dart';
import 'package:myapp/pages/chat_page.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class UserTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isLoggedIn;
  final VoidCallback onTap;

  const UserTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isLoggedIn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
  final theme = ShadTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.card,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(Icons.person, color: isLoggedIn ? theme.colorScheme.accent: theme.colorScheme.primary),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(title, style: theme.textTheme.h4, textAlign: TextAlign.left),
                Text(subtitle, style: theme.textTheme.p, textAlign: TextAlign.left),
                const SizedBox(width: 15),
              ],
            )
          ],

        )

        ),

      );
  }

}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<User> users = [];

  fetchUsers() async {
    ChatService chatService = ChatService();
    final u = await chatService.getAllUsers();
    setState(()=> 
      users = u
  );
  }



  // init state, fecth all users 
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }, icon: const Icon(Icons.settings)),
          IconButton(
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            }, 
            icon: const Icon(Icons.info),
          ),
      ]),
      drawer: const DrawerComponent(),
      body: Center(child: Column(
        children: [
          Text("Chat", style: theme.textTheme.h2 ),
          ...users.map(
            (user) => UserTile(
              title: user.name,
              subtitle: user.email,
              isLoggedIn: user.isLoggedIn,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(user.id)));
              },
              
            ),
          ),
        ],
      )),
      );
  }
}
