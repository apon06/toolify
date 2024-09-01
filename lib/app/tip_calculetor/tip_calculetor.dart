import 'package:flutter/material.dart';

class TipCalculatorHome extends StatefulWidget {
  const TipCalculatorHome({super.key});

  @override
  TipCalculatorHomeState createState() => TipCalculatorHomeState();
}

class TipCalculatorHomeState extends State<TipCalculatorHome> {
  final TextEditingController _billController = TextEditingController();
  double _tipPercentage = 15.0;
  double _tipAmount = 0.0;
  double _totalAmount = 0.0;

  void _calculateTip() {
    final double billAmount = double.tryParse(_billController.text) ?? 0.0;
    _tipAmount = (billAmount * _tipPercentage) / 100;
    _totalAmount = billAmount + _tipAmount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
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
                _calculateTip();
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tip Percentage: ${_tipPercentage.toStringAsFixed(0)}%'),
                Slider(
                  value: _tipPercentage,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _tipPercentage.toStringAsFixed(0),
                  onChanged: (double value) {
                    setState(() {
                      _tipPercentage = value;
                    });
                    _calculateTip();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Tip Amount:'),
                Text('\$${_tipAmount.toStringAsFixed(2)}'),
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
