import 'package:flutter/material.dart';

class BMRCalculator extends StatefulWidget {
  const BMRCalculator({super.key});

  @override
  BMRCalculatorState createState() => BMRCalculatorState();
}

class BMRCalculatorState extends State<BMRCalculator> {
  double _weight = 66.0;
  double _height = 167.0;
  int _age = 17;
  String _gender = 'Male';
  double _bmr = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateBMR();
  }

  void _calculateBMR() {
    setState(() {
      if (_gender == 'Male') {
        _bmr = 88.362 + (13.397 * _weight) + (4.799 * _height) - (5.677 * _age);
      } else {
        _bmr = 447.593 + (9.247 * _weight) + (3.098 * _height) - (4.330 * _age);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Gender', style: TextStyle(fontSize: 18)),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: const Text('Male'),
                    leading: Radio<String>(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                          _calculateBMR();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Female'),
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                          _calculateBMR();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Weight (kg): ${_weight.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 18)),
            Slider(
              value: _weight,
              min: 30,
              max: 150,
              divisions: 240,
              label: _weight.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  _weight = value;
                  _calculateBMR();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Height (cm): ${_height.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 18)),
            Slider(
              value: _height,
              min: 100,
              max: 220,
              divisions: 240,
              label: _height.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  _height = value;
                  _calculateBMR();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Age: $_age', style: const TextStyle(fontSize: 18)),
            Slider(
              value: _age.toDouble(),
              min: 10,
              max: 100,
              divisions: 90,
              label: _age.toString(),
              onChanged: (double value) {
                setState(() {
                  _age = value.toInt();
                  _calculateBMR();
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Your BMR: ${_bmr.toStringAsFixed(2)} kcal/day',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
