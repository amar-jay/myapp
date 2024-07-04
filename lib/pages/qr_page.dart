import 'package:flutter/material.dart';
import 'package:myapp/components/drawer.dart';
// import 'package:myapp/components/qr_scanner.dart';
import 'package:myapp/components/qr_scanner_simple.dart';
// import "package:shadcn_ui/shadcn_ui.dart";

class QrscannerPage extends StatefulWidget {
  /// Scan QR Code 
  const QrscannerPage({super.key});
   @override
   State<QrscannerPage> createState() => _QrscannerPageState();
}

class _QrscannerPageState extends State<QrscannerPage> {
  

  /// Suggested code may be subject to a license. Learn more: ~LicenseLog:1060000237.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code Scanner'),
      ),

      drawer: const DrawerComponent(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text('A simple Qr Code Scanner',
        style: TextStyle(fontSize: 16), textAlign: TextAlign.center,
        ),
        BarcodeScannerSimple(),
        // QrscannerComponent(),
        Text("Bombo class ☘️"),
        ])
      )
    );
  }
}