import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _milliseconds = 0;
  int _initialTime = 0; 
  bool _isRunning = false;
  int _selectedHours = 0;
  int _selectedMinutes = 0;
  int _selectedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _loadTimerState();
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _milliseconds = prefs.getInt('timer_milliseconds') ?? 0;
      _initialTime = prefs.getInt('initial_time') ?? 0;
      _isRunning = prefs.getBool('timer_is_running') ?? false;
      if (_isRunning && _milliseconds > 0) {
        _startTimer();
      }
    });
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timer_milliseconds', _milliseconds);
    await prefs.setInt('initial_time', _initialTime);
    await prefs.setBool('timer_is_running', _isRunning);
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_milliseconds > 0) {
        setState(() {
          _milliseconds -= 1000;
        });
        _saveTimerState();
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
      _timer?.cancel();
    });
    _saveTimerState();
  }

  void _resetTimer() {
    setState(() {
      _milliseconds = _initialTime;
      _isRunning = false;
      _timer?.cancel();
    });
    _saveTimerState();
  }

  @override
  void dispose() {
    _resetTimer();
    
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    final hours = (milliseconds ~/ 3600000).toString().padLeft(2, '0');
    final minutes = ((milliseconds ~/ 60000) % 60).toString().padLeft(2, '0');
    final seconds = ((milliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void _onTimeUnitSelected(int? value, String unit) {
    setState(() {
      if (unit == 'hours') {
        _selectedHours = value!;
      } else if (unit == 'minutes') {
        _selectedMinutes = value!;
      } else if (unit == 'seconds') {
        _selectedSeconds = value!;
      }
      _initialTime =
          (_selectedHours * 3600 + _selectedMinutes * 60 + _selectedSeconds) *
              1000;
      _milliseconds = _initialTime;
      _resetTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _isRunning ? _stopTimer : _startTimer,
          onLongPress: _resetTimer,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("141218"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeUnitSelector(
                      value: _selectedHours,
                      unit: 'hours',
                      max: 23,
                    ),
                    const SizedBox(width: 20),
                    _buildTimeUnitSelector(
                      value: _selectedMinutes,
                      unit: 'minutes',
                      max: 59,
                    ),
                    const SizedBox(width: 20),
                    _buildTimeUnitSelector(
                      value: _selectedSeconds,
                      unit: 'seconds',
                      max: 59,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  _formatTime(_milliseconds),
                  style: TextStyle(
                    fontSize: 48,
                    color: _isRunning ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeUnitSelector(
      {required int value, required String unit, required int max}) {
    return DropdownButton<int>(
      value: value,
      dropdownColor: HexColor("141218"),
      items: List.generate(max + 1, (index) => index).map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      }).toList(),
      onChanged: (value) => _onTimeUnitSelected(value, unit),
    );
  }
}
