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
      'Bluetooth adapter is ${state ?? 'not available'}',
      style: TextStyle(fontSize: 15));
  }  

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 80
    );
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [

          // ICON
          Icon(
            Icons.bluetooth,
            size: 80
          ),
          
          const SizedBox(height: 25),

          const Text("Bluetooth",
          style: TextStyle(fontSize: 20)),


        

          // Text

          // BUtton



      ],)

   
    );
  }
}
