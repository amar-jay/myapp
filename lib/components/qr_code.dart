import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
class QrcodeComponent extends StatefulWidget {
    const QrcodeComponent({super.key});

   @override
   State<QrcodeComponent> createState() => _QrcodeComponentState();
}

class _QrcodeComponentState extends State<QrcodeComponent> {

  final TextEditingController _qrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Text("QrcodeComponent", style: theme.textTheme.h3, textAlign: TextAlign.center,),
          const SizedBox(height: 15),
                  ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              
              child: ShadInput(
                      placeholder: const Text('Qrcode content'),
                      controller: _qrController,
                      keyboardType: TextInputType.emailAddress,
                ),
          ),
              QrImageView(
                  data: _qrController.text,
                  version: QrVersions.auto,
                  size: 200.0,
              ),
          ]);
    }
}