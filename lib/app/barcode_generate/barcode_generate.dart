import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeGenerate extends StatefulWidget {
  const BarcodeGenerate({super.key});

  @override
  State<BarcodeGenerate> createState() => _BarcodeGenerateState();
}

class _BarcodeGenerateState extends State<BarcodeGenerate> {
  var qrData = "";
  final int maxLength = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BarCode Generate'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              width: 320,
              height: 130,
              color: Colors.white,
              child: Center(
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: qrData,
                  width: 300,
                  height: 100,
                  backgroundColor: Colors.white,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: 321,
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
                            'Maximum 100 character limit reached',
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
