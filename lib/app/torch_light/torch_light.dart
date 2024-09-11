// import 'package:flutter/material.dart';
// import 'package:torch_light/torch_light.dart';

// class FlashlightHome extends StatefulWidget {
//   const FlashlightHome({super.key});

//   @override
//   FlashlightHomeState createState() => FlashlightHomeState();
// }

// class FlashlightHomeState extends State<FlashlightHome> {
//   bool _isFlashOn = false;

//   Future<void> _turnOnFlash() async {
//     try {
//       await TorchLight.enableTorch();
//     } catch (e) {
//       //
//     }
//   }

//   Future<void> _turnOffFlash() async {
//     try {
//       await TorchLight.disableTorch();
//     } catch (e) {
//       //
//     }
//   }

//   void _toggleFlash(bool value) {
//     setState(() {
//       _isFlashOn = value;
//     });

//     if (_isFlashOn) {
//       _turnOnFlash();
//     } else {
//       _turnOffFlash();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flashlight'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               _isFlashOn ? 'Flashlight is ON' : 'Flashlight is OFF',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Switch.adaptive(
//               value: _isFlashOn,
//               onChanged: _toggleFlash,
//               activeColor: Colors.blueAccent,
//               inactiveThumbColor: Colors.grey,
//             ),
//             const SizedBox(height: 20),
//             Icon(
//               _isFlashOn ? Icons.flash_on : Icons.flash_off,
//               color: _isFlashOn ? Colors.yellow : Colors.grey,
//               size: 100,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
