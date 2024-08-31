import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  DateTime? _selectedDate;
  String _calculatedAge = "";
  DateTime now = DateTime.now();
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _calculateAge();
      });
    });
  }

  void _calculateAge() {
    if (_selectedDate == null) return;

    final currentDate = DateTime.now();
    int years = currentDate.year - _selectedDate!.year;
    int months = currentDate.month - _selectedDate!.month;
    int days = currentDate.day - _selectedDate!.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(currentDate.year, currentDate.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    setState(() {
      _calculatedAge = "$years years ||$months months||$days days";
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70,
              width: 230,
              decoration: BoxDecoration(
                  color: HexColor("262a35"),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  _selectedDate == null
                      ? 'Today: $formattedDate'
                      : 'Birth Day: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _presentDatePicker,
                child: const Text(
                  'Choose Your Birth Date',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                  color: HexColor("262a35"),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  _selectedDate == null
                      ? "0 years  0 months  0 days"
                      : _calculatedAge,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
