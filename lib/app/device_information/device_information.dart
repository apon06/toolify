import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:system_info2/system_info2.dart';
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
          ],
        ),
      ),
    );
  }
}
