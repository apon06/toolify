// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toolify/app/cube_timer/cube_timer.dart';
import 'package:toolify/app/money_manage/money_manage.dart';
import 'package:toolify/app/tip_calculetor/tip_calculetor.dart';
import 'package:toolify/app/vat_calculator/vat_calculator.dart';
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
// import '../../../app/torch_light/torch_light.dart';
import '../../../core/quick_action.dart';
import '../widgets/home_page_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // checkForUpdate();
    initializeAction(context);
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
                    // const HomePageCard(
                    //   image: 'https://i.postimg.cc/YCLbjtxy/torch-light.png',
                    //   text: 'Flash Light',
                    //   location: FlashlightHome(),
                    // ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomePageText(text: 'Calculator'),
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
                    const HomePageCard(
                      image: 'https://i.postimg.cc/SxfLw2Gv/vat.png',
                      text: 'VAT Calculator',
                      location: VatCalculator(),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomePageText(text: 'Image'),
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
