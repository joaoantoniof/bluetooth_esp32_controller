import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../utils/snackbar.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key, this.adapterState});

  final BluetoothAdapterState? adapterState;


  Widget buildTitle(BuildContext context) {
    String? state = adapterState?.toString().split(".").last;
    return Text(
      'Bluetooth adapter is ${state ?? 'not available'}.',
      style: TextStyle(fontSize: 15));
  } 

  Widget buildSubTitle(BuildContext context) {
    return Text('Enable bluetooth on your phone.',style: TextStyle(fontSize: 12));
  }  

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 80,
      color: Colors.red);
  }

  Widget buildTurnOnButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondaryContainer),
      child: const Text('Turn on bluetooth'),
      
      onPressed: () async {
        try {
          if (!kIsWeb && Platform.isAndroid) {
            await FlutterBluePlus.turnOn();
          }
        } catch (e, backtrace) {
          Snackbar.show(ABC.a, prettyException("Error Turning On:", e), success: false);
          print("$e");
          print("backtrace: $backtrace");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyA,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              // Icon
              buildBluetoothOffIcon(context),

              // Spacer
              const SizedBox(height: 10),

              // Text
              buildTitle(context),
              buildSubTitle(context),

              // Spacer
              const SizedBox(height: 10),
              
              // Button 
              if (!kIsWeb && Platform.isAndroid) 
              buildTurnOnButton(context)

            ],
          ),
        ),
      ),
    );
  }
}
