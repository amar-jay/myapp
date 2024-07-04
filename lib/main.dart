import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/components/auth_gate.dart';
import 'package:myapp/firebase_options.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  const String scriptUrl = "https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.js";

  if (kIsWeb) {
    MobileScannerPlatform.instance.setBarcodeLibraryScriptUrl(scriptUrl);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      debugShowCheckedModeBanner: false,
      darkTheme: ShadThemeData(colorScheme: const ShadRedColorScheme.dark(), brightness: Brightness.dark),
      home: const AuthGate(),
      materialThemeBuilder: (context, theme) {
        return theme.copyWith(
          appBarTheme: const AppBarTheme(toolbarHeight: 52),
        );
      },
    );
  }
}