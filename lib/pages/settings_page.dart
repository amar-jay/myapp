import 'package:flutter/material.dart';
import 'package:myapp/components/drawer.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const SettingsPage());
}

const languages = {
  'en_US': 'English',
  'es_ES': 'Spanish',
  'tr_TR': 'Turkish',
  'fr_FR': 'French'
};

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1127494436.
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final TextEditingController _nameController = TextEditingController();
  String? myLanguage;
  User? currentUser;


  _showToast(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  _submit(BuildContext context) {
    try{
      if (currentUser == null) {
        throw Exception('Error: User not found');
      }

      ChatService chatService = ChatService();
      setState(() {
        currentUser!.name = _nameController.text;
      });
      //currentUser.language = myLanguage;
      chatService.addUser(currentUser!);
      _showToast(context, 'Settings Saved');
    } catch (e) {
      _showToast(context, e.toString());
    }
  }

  fetchUser() async {
    AuthService authService = AuthService();
    User user = await authService.getCurrentUser();
    setState(() {
      currentUser = user;
    });
    setState(() => 
    _nameController.text = user.name
    );
    }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);




    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerComponent(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),

      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: theme.textTheme.h1, textAlign: TextAlign.center,),
            const SizedBox(height: 16),
            
            const Text('Name'),
            ShadInput(placeholder: Text(currentUser?.name ?? "Name"), controller: _nameController),
            const SizedBox(height: 8),

            // const Text('Age'),
            // const ShadInput(placeholder: Text('Age'), keyboardType: TextInputType.number),
            // const SizedBox(height: 8),

            // const Text('Email'),
            // const ShadInput(placeholder: Text('Email'), keyboardType: TextInputType.emailAddress),
            // const SizedBox(height: 8),
            const Text('Language'),

            ShadSelect<String>(
               placeholder: const Text('Select'),
               options: languages.entries
                   .map(
                       (e) => ShadOption(value: e.key, child: Text(e.value)))
                   .toList(),
               selectedOptionBuilder: (context, key) {
                 return Text(languages[key] ?? '--');
               },
               onChanged: (value) {
                print(value);
                setState(()=> 
                  myLanguage = value
                );
               },
             ),

            ShadButton(
                 text: const Text('Submit'),
                 onPressed: () {
                   _submit(context);
                 }
              ),
          ],
        ),
    ),
    ),
    );
  }
}