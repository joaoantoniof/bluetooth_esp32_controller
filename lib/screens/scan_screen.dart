import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'device_screen.dart';
import '../utils/snackbar.dart';
import '../widgets/system_device_tile.dart';
import '../widgets/scan_result_tile.dart';
import '../utils/extra.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    // Start scanning as soon as the screen is shown
    onScanPressed();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      if (mounted) {
        setState(() => _scanResults = results);
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      if (mounted) {
        setState(() => _isScanning = state);
      }
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    try {
      // `withServices` is required on iOS for privacy purposes, ignored on android.
      var withServices = [Guid("180f")]; // Battery Level Service
      _systemDevices = await FlutterBluePlus.systemDevices(withServices);
    } catch (e, backtrace) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e), success: false);
      print(e);
      print("backtrace: $backtrace");
    }
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
      );
    } catch (e, backtrace) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
      print(e);
      print("backtrace: $backtrace");
    }
    if (mounted) {
      setState(() {});
    }
  }


//#define SERVICE_UUID "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
//#define MESSAGE_CHARACTERISTIC_UUID "6d68efe5-04b6-4a85-abc4-c2670b7bf7fd"
//#define BOX_CHARACTERISTIC_UUID "f27b53ad-c63d-49a0-8c0f-9f297e6cc520"


  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e, backtrace) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e), success: false);
      // print(e);
      // print("backtrace: $backtrace");
    }
  }

  void onConnectPressed(BluetoothDevice device) {
    device.connectAndUpdateStream().catchError((e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
    });
    MaterialPageRoute route = MaterialPageRoute(
        // TODO builder: (context) => DeviceScreen(device: device), settings: RouteSettings(name: '/DeviceScreen'));
        builder: (context) => DeviceScreen(device: device), settings: RouteSettings(name: '/my_page'));

    Navigator.of(context).push(route);
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(Duration(milliseconds: 500));
  }

  Widget buildScanButton() {
    final button = _isScanning
        ? ElevatedButton(
            onPressed: onStopPressed,
            child: const Text("Stop"),
          )
        : ElevatedButton(
            onPressed: onScanPressed,
            child: const Text("Scan"),
          );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isScanning) buildSpinner(),
        button,
      ],
    );
  }

  Widget buildSpinner() {
    return const Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      ),
    );
  }


  List<Widget> _buildSystemDeviceTiles() {
    return _systemDevices.map(
          (d) => SystemDeviceTile(
            device: d,
            onOpen: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DeviceScreen(device: d),
                settings: RouteSettings(name: '/DeviceScreen'),
              ),
            ),
            onConnect: () => onConnectPressed(d),
          ),
        ).toList();
  }

  Iterable<Widget> _buildScanResultTiles() {
    return _scanResults.map((r) => ScanResultTile(result: r, onTap: () => onConnectPressed(r.device)));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(key: Snackbar.snackBarKeyB,
      child: Scaffold(
        
        // App bar
        appBar: AppBar(
          centerTitle: false,
          title: Text("Bluetooth devices", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer),
        
        // Refresh body
        body: 
          RefreshIndicator(
          color: Theme.of(context).colorScheme.secondaryContainer, // Custom color
            onRefresh: onRefresh,
            child: ListView(
              children: <Widget>[
       
                ..._buildSystemDeviceTiles(),
                
                ..._buildScanResultTiles(),

              ],
            ),
          ),
          
          // floatingActionButton: buildScanButton(),
      ),
    );
  }
}
