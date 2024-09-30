// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toolify/screen/Setting/screen/about_toolify.dart';
import 'package:toolify/screen/Setting/screen/app_information_page.dart';
import 'package:toolify/screen/Setting/screen/change_log_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/toolify_ads.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      bottomNavigationBar: const ToolifyAds(
        apiUrl:
            "https://apon06.github.io/bookify_api/toolify_ads/toolify_ads_1.json",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                trailing: const Icon(Icons.info_rounded),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (b) => const AboutToolify(),
                    ),
                  );
                },
                title: const Text('About Toolidy'),
                trailing: const Icon(Icons.info_rounded),
              ),
            ),
            const ToolifyAds(
              apiUrl:
                  "https://apon06.github.io/bookify_api/toolify_ads/toolify_ads_2.json",
            ),
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
                onTap: () async {
                  String privacyUrl =
                      'https://sites.google.com/view/toolify-hub/home';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.privacy_tip),
              ),
            ),
            const ToolifyAds(
              apiUrl:
                  "https://apon06.github.io/bookify_api/toolify_ads/toolify_ads_3.json",
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl =
                      'https://sites.google.com/view/toolify-terms/home';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Terms & Conditions'),
                trailing: const Icon(Icons.assignment),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl = 'https://github.com/apon06';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Github'),
                trailing: const Icon(FontAwesomeIcons.github),
              ),
            ),
             const ToolifyAds(
              apiUrl:
                  "https://apon06.github.io/bookify_api/toolify_ads/toolify_ads_4.json",
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl = 'https://t.me/+-xBeTl30frgwNWI1';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Telegram'),
                trailing: const Icon(Icons.telegram),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
