
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrscannerComponent extends StatefulWidget {
    const QrscannerComponent({super.key});

   @override
   State<QrscannerComponent> createState() => _QrscannerComponentState();
}

class _QrscannerComponentState extends State<QrscannerComponent> {

final MobileScannerController controller = MobileScannerController(
  // required options for the scanner
  torchEnabled: true,

);

  Widget _buildBarcodesListView() {
      final theme = ShadTheme.of(context);
      return StreamBuilder<BarcodeCapture>(
        stream: controller.barcodes,
        builder: (context, snapshot) {
          final barcodes = snapshot.data?.barcodes;

          if (barcodes == null || barcodes.isEmpty) {
            return  Center(
              child: Text(
                'Scan Something!',
                style: theme.textTheme.h3,
              ),
            );
          }

          return ListView.builder(
            itemCount: barcodes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  barcodes[index].rawValue ?? 'No raw value',
                  overflow: TextOverflow.fade,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Text("QrscannerComponent", style: theme.textTheme.h3, textAlign: TextAlign.center,),
          const SizedBox(height: 15),
              MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return Text(error.toString());
            },
            fit: BoxFit.contain,
          ),
          Expanded(child: _buildBarcodesListView()),
          Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToggleFlashlightButton(controller: controller),
                      const Spacer(),

                      StartStopMobileScannerButton(controller: controller),

                    ],
                  ),
          ]);
    }

  // @override
  // Future<void> dispose() async {
  //   super.dispose();
  //   await controller.dispose();
  // }
}

class StartStopMobileScannerButton extends StatelessWidget {
  const StartStopMobileScannerButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return IconButton(
            color: Colors.white,
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: () async {
              await controller.start();
            },
          );
        }

        return IconButton(
          color: Colors.white,
          icon: const Icon(Icons.stop),
          iconSize: 32.0,
          onPressed: () async {
            await controller.stop();
          },
        );
      },
    );
  }
}


class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_auto),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.off:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_off),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.on:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_on),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.unavailable:
            return const Icon(
              Icons.no_flash,
              color: Colors.grey,
            );
        }
      },
    );
  }
}