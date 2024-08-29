import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimerStateApp createState() => _TimerStateApp();
}

class _TimerStateApp extends State<TimerApp> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds += 10;
      });
    });
  }

  void _stopTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void _resetTimer() {
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
      _timer?.cancel();
    });
  }

  String _formatTime(int milliseconds) {
    final minutes = (milliseconds ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((milliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
    final millis = ((milliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds:$millis';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _isRunning ? _stopTimer : _startTimer,
          onLongPress: _resetTimer,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("141218"),
            // color: ,
            child: Center(
              child: Text(
                _formatTime(_milliseconds),
                style: TextStyle(
                  fontSize: 48,
                  color: _isRunning ? Colors.red : Colors.green,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}