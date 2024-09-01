import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class QrGenerate extends StatefulWidget {
  const QrGenerate({super.key});

  @override
  State<QrGenerate> createState() => _QrGeneratePageS();
}

class _QrGeneratePageS extends State<QrGenerate> {
  final ScreenshotController _screenshotController = ScreenshotController();
  var qrData = "";
  final int maxLength = 2200;

  Future<void> _captureAndSave() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      final result = await ImageGallerySaver.saveImage(image);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result != null
              ? 'QR code saved to gallery!'
              : 'Failed to save QR code'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code Generate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _captureAndSave,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Screenshot(
              controller: _screenshotController,
              child: Container(
                width: 320,
                height: 320,
                color: Colors.white,
                child: Center(
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: qrData,
                    width: 300,
                    height: 300,
                    backgroundColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: 323,
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
