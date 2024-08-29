import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends StatefulWidget {
  const QrGenerate({super.key});

  @override
  State<QrGenerate> createState() => _QrGeneratePageS();
}

class _QrGeneratePageS extends State<QrGenerate> {
  var qrData = "";
  final int maxLength = 2200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code Generate'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 300.0,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: 303,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  maxLength: maxLength,
                  onChanged: (value) {
                    setState(() {
                      qrData = value;
                    });

                    if (value.length == maxLength) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Maximum 2200 character limit reached',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red[700],
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                        ),
                      );
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Text',
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
