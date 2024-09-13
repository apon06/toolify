import 'package:flutter/material.dart';

class VatCalculator extends StatefulWidget {
  const VatCalculator({super.key});

  @override
  VatCalculatorState createState() => VatCalculatorState();
}

class VatCalculatorState extends State<VatCalculator> {
  final TextEditingController _billController = TextEditingController();
  double _vatPercentage = 15.0;
  double _vatAmount = 0.0;
  double _totalAmount = 0.0;

  void _calculateVat() {
    final double billAmount = double.tryParse(_billController.text) ?? 0.0;
    _vatAmount = (billAmount * _vatPercentage) / 100;
    _totalAmount = billAmount + _vatAmount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vat Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _billController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Enter bill amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _calculateVat();
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vat Percentage: ${_vatPercentage.toStringAsFixed(0)}%'),
                Slider(
                  value: _vatPercentage,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _vatPercentage.toStringAsFixed(0),
                  onChanged: (double value) {
                    setState(() {
                      _vatPercentage = value;
                    });
                    _calculateVat();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Vat Amount:'),
                Text('\$${_vatAmount.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Total Amount:'),
                Text('\$${_totalAmount.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
