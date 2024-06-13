import 'package:flutter/material.dart';
import 'package:myapp/components/drawer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const SettingsPage());
}

const languages = {
  'English': 'en_US',
  'Spanish': 'es_ES',
  'Turkish': 'tr_TR',
  'French': 'fr_FR'
};

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // This widget is the root of your application.
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
            const ShadInput(placeholder: Text('Name')),
            const SizedBox(height: 8),

            const Text('Age'),
            const ShadInput(placeholder: Text('Age'), keyboardType: TextInputType.number),
            const SizedBox(height: 8),

            const Text('Email'),
            const ShadInput(placeholder: Text('Email'), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 8),
            const Text('Language'),

            ShadSelect<String>(
               placeholder: const Text('Select'),
               options: languages.entries
                   .map(
                       (e) => ShadOption(value: e.value, child: Text(e.key)))
                   .toList(),
               selectedOptionBuilder: (context, key) {
                 return Text(languages[key]!);
               },
               onChanged: (value) {},
             ),
            ShadButton(
                 text: const Text('Submit'),
                 onPressed: () {}
              ),
          ],
        ),
    ),
    ),
    );
  }
}