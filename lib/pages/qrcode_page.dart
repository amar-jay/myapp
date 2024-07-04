import 'package:flutter/material.dart';
import 'package:myapp/components/drawer.dart';
import 'package:myapp/components/qr_code.dart';
import "package:shadcn_ui/shadcn_ui.dart";

class QrcodePage extends StatefulWidget {
  
  const QrcodePage({super.key});
   @override
   State<QrcodePage> createState() => _QrcodePageState();
}

class _QrcodePageState extends State<QrcodePage> {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1060000237.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code'),
      ),

      drawer: const DrawerComponent(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text('A simple Qr Code display',
        style: TextStyle(fontSize: 16), textAlign: TextAlign.center,
        ),
        Text("QrcodeComponent"),
        QrcodeComponent(),
        ])
      )
    );
  }
}