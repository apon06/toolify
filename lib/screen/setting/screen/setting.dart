import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toolify/screen/setting/screen/app_information_page.dart';
import 'package:toolify/screen/setting/screen/change_log_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String version = "";
  String appName = "";
  String packageName = "";

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    String versionNumber = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      version = '$versionNumber+$buildNumber';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (b) => const ChangeLogPage(),
                  ),
                );
              },
              title: const Text('Changelog'),
              trailing: const Icon(Icons.history),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (b) => const AppInformationPage(),
                  ),
                );
              },
              title: const Text('App Information'),
              trailing: Icon(Icons.info_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
