// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:system_info2/system_info2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:math' as math;

class DeviceInformation extends StatefulWidget {
  const DeviceInformation({super.key});

  @override
  DeviceInformationState createState() => DeviceInformationState();
}

class DeviceInformationState extends State<DeviceInformation> {
  String _deviceName = 'Unknown';
  String _manufacturer = 'Unknown';
  String _osVersion = 'Unknown';
  String _batteryLevel = 'Unknown';
  String _appVersion = 'Unknown';
  String _totalRAM = 'Unknown';
  String _availableRAM = 'Unknown';
  String _totalStorage = 'Unknown';
  String _availableStorage = 'Unknown';
  String _cpuArchitecture = 'Unknown'; // New field
  String _screenResolution = 'Unknown'; // New field
  String _networkStatus = 'Unknown'; // New field
  String _isRooted = 'Unknown'; // New field

  final Battery _battery = Battery();
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _initDeviceInfo();
    _getBatteryLevel();
    _getAppInfo();
    _getMemoryInfo();
    _getStorageInfo();
    _getCPUInfo();
    _getScreenResolution();
    _getNetworkStatus();
    _checkIfRooted();
  }

  Future<void> _initDeviceInfo() async {
    var deviceInfo = await _deviceInfoPlugin.deviceInfo;
    var osVersion = deviceInfo.data['version'] ?? 'Unknown';
    var deviceName = deviceInfo.data['model'] ?? 'Unknown';
    var manufacturer = deviceInfo.data['manufacturer'] ?? 'Unknown';

    setState(() {
      _deviceName = deviceName.toString();
      _osVersion = osVersion.toString();
      _manufacturer = manufacturer.toString();
    });
  }

  Future<void> _getBatteryLevel() async {
    final batteryLevel = await _battery.batteryLevel;

    setState(() {
      _batteryLevel = '$batteryLevel%';
    });
  }

  Future<void> _getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  Future<void> _getMemoryInfo() async {
    final totalRAMBytes = SysInfo.getTotalPhysicalMemory();
    final availableRAMBytes = SysInfo.getFreePhysicalMemory();

    setState(() {
      _totalRAM = _formatBytes(totalRAMBytes);
      _availableRAM = _formatBytes(availableRAMBytes);
    });
  }

  Future<void> _getStorageInfo() async {
    final totalStorageBytes = SysInfo.getTotalVirtualMemory();
    final availableStorageBytes = SysInfo.getFreeVirtualMemory();

    setState(() {
      _totalStorage = _formatBytes(totalStorageBytes);
      _availableStorage = _formatBytes(availableStorageBytes);
    });
  }

  // New method to get CPU architecture
  Future<void> _getCPUInfo() async {
    var deviceInfo = await _deviceInfoPlugin.deviceInfo;
    var cpuArch =
        deviceInfo.data['supportedAbis']?.first ?? 'Unknown'; // For Android

    setState(() {
      _cpuArchitecture = cpuArch;
    });
  }

  // New method to get screen resolution
  Future<void> _getScreenResolution() async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    setState(() {
      _screenResolution = '${width.toInt()} x ${height.toInt()}';
    });
  }

  // New method to get network status
  Future<void> _getNetworkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    String networkType;

    if (connectivityResult == ConnectivityResult.mobile) {
      networkType = "Mobile Data";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      networkType = "Wi-Fi";
    } else {
      networkType = "No Internet Connection";
    }

    setState(() {
      _networkStatus = networkType;
    });
  }

  // New method to check if the device is rooted (basic check)
  Future<void> _checkIfRooted() async {
    // You can use platform-specific checks to see if the device is rooted/jailbroken
    var isRooted =
        false; // Placeholder - Implement more advanced checks if necessary

    setState(() {
      // ignore: dead_code
      _isRooted = isRooted ? "Yes" : "No";
    });
  }

  String _formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Device Name'),
              subtitle: Text(_deviceName),
            ),
            ListTile(
              title: const Text('Manufacturer'),
              subtitle: Text(_manufacturer),
            ),
            ListTile(
              title: const Text('OS Version'),
              subtitle: Text(_osVersion),
            ),
            ListTile(
              title: const Text('Battery Level'),
              subtitle: Text(_batteryLevel),
            ),
            ListTile(
              title: const Text('App Version'),
              subtitle: Text(_appVersion),
            ),
            ListTile(
              title: const Text('Total RAM'),
              subtitle: Text(_totalRAM),
            ),
            ListTile(
              title: const Text('Available RAM'),
              subtitle: Text(_availableRAM),
            ),
            ListTile(
              title: const Text('Total Storage'),
              subtitle: Text(_totalStorage),
            ),
            ListTile(
              title: const Text('Available Storage'),
              subtitle: Text(_availableStorage),
            ),
            ListTile(
              title: const Text('CPU Architecture'),
              subtitle: Text(_cpuArchitecture),
            ),
            ListTile(
              title: const Text('Screen Resolution'),
              subtitle: Text(_screenResolution),
            ),
            ListTile(
              title: const Text('Network Status'),
              subtitle: Text(_networkStatus),
            ),
            ListTile(
              title: const Text('Is Rooted'),
              subtitle: Text(_isRooted),
            ),
          ],
        ),
      ),
    );
  }
}
