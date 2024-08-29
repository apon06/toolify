import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toolify/app/cube_timer/cube_timer.dart';
import 'package:toolify/screen/home/widgets/home_page_text.dart';
import '../../../app/countdown_timer/countdown_timer.dart';
import '../../../app/plant_identify/plant_identify_page.dart';
import '../../../app/qr_generate/qr_generate_page.dart';
import '../widgets/home_page_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('191a1f'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomePageText(text: 'Random Apps'),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: const [
                    HomePageCard(
                      image: 'https://i.postimg.cc/sfmXjh3Q/plant.png',
                      text: 'Plant Find',
                      location: PlantIdentifierPage(),
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/jScWH1JR/qr-code-gen.png',
                      text: 'Qr Generate',
                      location: QrGeneratePage(),
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/59Xq1TPH/timer2.png',
                      text: 'Timer',
                      location: TimerApp(),
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/wvQ7KSMG/countdown.png',
                      text: 'Countdown Timer',
                      location: CountdownTimer(),
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Profit Calculetor',
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const HomePageText(text: 'Product'),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: const [
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'BMI Calculetor',
                      location: HomePage(),
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'BMR Calculeror',
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Age Calculetor',
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Tip Calculetor',
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Profit Calculetor',
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Profit Calculetor',
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Profit Calculetor',
                    ),
                    HomePageCard(
                      image: 'https://i.postimg.cc/QMWYLmrh/bmi.png',
                      text: 'Profit Calculetor',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
