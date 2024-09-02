import 'package:flutter/material.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  DiscountPageState createState() => DiscountPageState();
}

class DiscountPageState extends State<DiscountPage> {
  double _amount = 0.0;
  double _discount = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discount Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Discounted Price: \$${(_amount - (_amount * _discount / 100)).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Discount: ${_discount.toInt()}%',
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              value: _discount,
              min: 0,
              max: 100,
              divisions: 100,
              label: _discount.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _discount = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
