// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toolify/app/cube_timer/cube_timer.dart';
import 'package:toolify/app/money_manage/money_manage.dart';
import 'package:toolify/app/tip_calculetor/tip_calculetor.dart';
import 'package:toolify/screen/home/widgets/home_page_text.dart';
import '../../../app/age_calculator/age_calculator.dart';
import '../../../app/barcode_generate/barcode_generate.dart';
import '../../../app/bmi_calculetor/bmi_calculetor.dart';
import '../../../app/bmr_calculetor/bmr_calculetor.dart';
import '../../../app/countdown_timer/countdown_timer.dart';
import '../../../app/device_information/device_information.dart';
import '../../../app/discount_app/discount_app.dart';
import '../../../app/image_compresse/image_compresse.dart';
import '../../../app/plant_identify/plant_identify.dart';
import '../../../app/qr_generate/qr_generate.dart';
import '../../../core/quick_action.dart';
import '../widgets/home_page_card.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkForUpdate();
    initializeAction(context);
  }

  Future<void> checkForUpdate() async {
    try {
      final response = await http.get(
          Uri.parse('https://apon06.github.io/bookify_api/app_update.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String latestVersion = data['latest_version'];
        String updateMessage = data['update_message'];

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String currentVersion = packageInfo.version;

        if (latestVersion != currentVersion) {
          showUpdateDialog(updateMessage);
        }
      } else {
        //
      }
    } catch (e) {
      //
    }
  }

  void showUpdateDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Available'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Later'),
          ),
          TextButton(
            onPressed: () async {
              const String appUpdateUrl =
                  'https://github.com/apon06/toolify/releases';

              final Uri url = Uri.parse(appUpdateUrl);

              if (await canLaunch(url.toString())) {
                await launch(url.toString());
              } else {
                await launch(url.toString());
              }
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('191a1f'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomePageText(text: 'Random Apps'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildListDelegate(
                  [
                    const HomePageCard(
                      image: 'https://i.postimg.cc/sfmXjh3Q/plant.png',
                      text: 'Plant Find',
                      location: PlantIdentifier(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/jScWH1JR/qr-code-gen.png',
                      text: 'Qr Generate',
                      location: QrGenerate(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/7hhxhZDp/barcode.png',
                      text: 'BarCode Generate',
                      location: BarcodeGenerate(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/59Xq1TPH/timer2.png',
                      text: 'Timer',
                      location: TimerApp(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/wvQ7KSMG/countdown.png',
                      text: 'Countdown Timer',
                      location: CountdownTimer(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/59mdMCrb/device-info.png',
                      text: 'Device Info',
                      location: DeviceInformation(),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    HomePageText(text: 'Calculator'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildListDelegate(
                  [
                    const HomePageCard(
                      image: 'https://i.postimg.cc/zXnyVBB3/bmr.png',
                      text: 'BMR Calculetor',
                      location: BMRCalculator(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'BMI Calculator',
                      location: BMICalculatorScreen(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/hvhn8LM2/age-cal.png',
                      text: 'Age Calculator',
                      location: AgeCalculator(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/wvF7P60T/tip.png',
                      text: 'Tip Calculator',
                      location: TipCalculatorHome(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/Ssm6N7TV/money-manage.png',
                      text: 'Money Manage',
                      location: MoneyManage(),
                    ),
                    const HomePageCard(
                      image: 'https://i.postimg.cc/gk4QXB5x/discount.png',
                      text: 'Discount Money',
                      location: DiscountPage(),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    HomePageText(text: 'Image'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildListDelegate(
                  [
                    const HomePageCard(
                      image:
                          'https://i.postimg.cc/fbtb5m77/image-compressor.png',
                      text: 'Image Compresse',
                      location: ImageCompresse(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
