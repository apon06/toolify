import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BarcodeGenerate extends StatefulWidget {
  const BarcodeGenerate({super.key});

  @override
  State<BarcodeGenerate> createState() => _BarcodeGenerateState();
}

class _BarcodeGenerateState extends State<BarcodeGenerate> {
  var data = "";
  final int maxLength = 100;
  Barcode selectedBarcode = Barcode.code128();
  bool isSnackBarShown = false;

  final Map<String, Barcode> barcodeTypes = {
    'Code 128': Barcode.code128(),
    'Code 39': Barcode.code39(),
    'EAN-13': Barcode.ean13(),
    'UPC-A': Barcode.upcA(),
    'EAN-8': Barcode.ean8(),
    'ITF': Barcode.itf(),
    'Code 93': Barcode.code93(),
    'Codabar': Barcode.codabar(),
    'PDF417': Barcode.pdf417(),
    'Aztec': Barcode.aztec(),
    'Data Matrix': Barcode.dataMatrix(),
    'ITF-14': Barcode.itf14(),
    'ITF-16': Barcode.itf16(),
    'QR Code': Barcode.qrCode(),
    'EAN-2': Barcode.ean2(),
    'EAN-5': Barcode.ean5(),
    'ISBN': Barcode.isbn(),
    'RM4SCC': Barcode.rm4scc(),
    'Telepen': Barcode.telepen(),
    'UPC-E': Barcode.upcE(),
  };

  final Map<Barcode, Map<String, dynamic>> barcodeConstraints = {
    Barcode.code128(): {'maxLength': 100, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Code 128'},
    Barcode.code39(): {'maxLength': 43, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Code 39'},
    Barcode.ean13(): {'maxLength': 13, 'keyboardType': TextInputType.number, 'hintText': 'Enter 13-digit EAN-13 number'},
    Barcode.upcA(): {'maxLength': 12, 'keyboardType': TextInputType.number, 'hintText': 'Enter 12-digit number for UPC-A'},
    Barcode.ean8(): {'maxLength': 8, 'keyboardType': TextInputType.number, 'hintText': 'Enter 8-digit EAN-8 number'},
    Barcode.itf(): {'maxLength': 14, 'keyboardType': TextInputType.number, 'hintText': 'Enter 14-digit number for ITF'},
    Barcode.code93(): {'maxLength': 20, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Code 93'},
    Barcode.codabar(): {'maxLength': 16, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Codabar'},
    Barcode.pdf417(): {'maxLength': 2000, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for PDF417'},
    Barcode.aztec(): {'maxLength': 300, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Aztec'},
    Barcode.dataMatrix(): {'maxLength': 2335, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Data Matrix'},
    Barcode.itf14(): {'maxLength': 14, 'keyboardType': TextInputType.number, 'hintText': 'Enter 14-digit number for ITF-14'},
    Barcode.itf16(): {'maxLength': 16, 'keyboardType': TextInputType.number, 'hintText': 'Enter 16-digit number for ITF-16'},
    Barcode.qrCode(): {'maxLength': 2200, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for QR Code'},
    Barcode.ean2(): {'maxLength': 2, 'keyboardType': TextInputType.number, 'hintText': 'Enter 2-digit number for EAN-2'},
    Barcode.ean5(): {'maxLength': 5, 'keyboardType': TextInputType.number, 'hintText': 'Enter 5-digit number for EAN-5'},
    Barcode.isbn(): {'maxLength': 13, 'keyboardType': TextInputType.number, 'hintText': 'Enter 13-digit ISBN number'},
    Barcode.rm4scc(): {'maxLength': 20, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for RM4SCC'},
    Barcode.telepen(): {'maxLength': 30, 'keyboardType': TextInputType.text, 'hintText': 'Enter text for Telepen'},
    Barcode.upcE(): {'maxLength': 8, 'keyboardType': TextInputType.number, 'hintText': 'Enter 8-digit number for UPC-E'},
  };

  @override
  Widget build(BuildContext context) {
    final String selectedKey = barcodeTypes.entries
        .firstWhere(
          (entry) => entry.value == selectedBarcode,
          orElse: () => barcodeTypes.entries.first,
        )
        .key;

    final constraints = barcodeConstraints[selectedBarcode] ?? {};
    final int? maxAllowedLength = constraints['maxLength'];
    final TextInputType keyboardType = constraints['keyboardType'] ?? TextInputType.text;
    final String hintText = constraints['hintText'] ?? 'Enter Your Text';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Generator'),
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
                  barcode: selectedBarcode,
                  data: data,
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
                  keyboardType: keyboardType,
                  maxLength: maxAllowedLength ?? maxLength,
                  onChanged: (value) {
                    setState(() {
                      data = value;

                      // Show SnackBar if input exceeds max length
                      if (maxAllowedLength != null && value.length > maxAllowedLength) {
                        if (!isSnackBarShown) {
                          isSnackBarShown = true;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Maximum $maxAllowedLength character limit reached for $selectedKey.',
                                style: const TextStyle(color: Colors.white),
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
                      } else {
                        isSnackBarShown = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    counterText: "",
                    errorText: (maxAllowedLength != null && data.length > maxAllowedLength)
                        ? 'Text exceeds the maximum length of $maxAllowedLength'
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedKey,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBarcode = barcodeTypes[newValue!]!;
                  data = "";
                  isSnackBarShown = false; // Reset SnackBar shown state
                });
              },
              items: barcodeTypes.keys.map<DropdownMenuItem<String>>((key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
