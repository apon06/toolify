import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  BMICalculatorScreenState createState() => BMICalculatorScreenState();
}

class BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _height = 167.0; // Initial height in cm
  double _weight = 68.0; // Initial weight in kg

  double get _bmi {
    double heightInMeters = _height / 100;
    return _weight / (heightInMeters * heightInMeters);
  }

  Color get _bmiTextColor {
    if (_bmi < 18.5) {
      return Colors.blue; // Underweight
    } else if (_bmi >= 18.5 && _bmi <= 24.9) {
      return Colors.green; // Normal
    } else if (_bmi >= 25 && _bmi <= 29.9) {
      return Colors.orange; // Overweight
    } else {
      return Colors.red; // Obesity
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your BMI is: ${_bmi.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _bmiTextColor, // Change color based on BMI
              ),
            ),
            const SizedBox(height: 40),
            Slider(
              value: _height,
              min: 50.0,
              max: 250.0,
              divisions: 200,
              label: _height.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _height = value;
                });
              },
            ),
            Text(
              'Height: ${_height.toStringAsFixed(1)} cm',
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              value: _weight,
              min: 10.0,
              max: 150.0,
              divisions: 140,
              label: _weight.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _weight = value;
                });
              },
            ),
            Text(
              'Weight: ${_weight.toStringAsFixed(1)} kg',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
