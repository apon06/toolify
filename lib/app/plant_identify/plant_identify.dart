// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PlantIdentifier extends StatefulWidget {
//   const PlantIdentifier({super.key});

//   @override
//   _PlantIdentifierPageS createState() => _PlantIdentifierPageS();
// }

// class _PlantIdentifierPageS extends State<PlantIdentifier> {
//   File? _image;
//   String _result = '';
//   bool _isLoading = false;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _getImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         _result = '';
//       }
//     });
//   }

//   Future<void> _identifyPlant() async {
//     if (_image == null) return;

//     setState(() {
//       _isLoading = true;
//     });

//     const apiKey = 'ha ha your api key';
//     const apiUrl =
//         'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

//     try {
//       final bytes = await _image!.readAsBytes();
//       final base64Image = base64Encode(bytes);

//       final response = await http.post(
//         Uri.parse('$apiUrl?key=$apiKey'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'contents': [
//             {
//               'parts': [
//                 {
//                   'text':
//                       'Identify this plant and provide some information about it.'
//                 },
//                 {
//                   'inline_data': {
//                     'mime_type': 'image/jpeg',
//                     'data': base64Image,
//                   }
//                 }
//               ]
//             }
//           ]
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           _result = data['candidates'][0]['content']['parts'][0]['text'];
//         });
//       } else {
//         setState(() {
//           _result = 'Error ${response.statusCode}: ${response.body}';
//           // print('API Response: ${response.body}'); // Log the response for debugging
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _result = 'Error: $e';
//         // print('Exception: $e'); // Log exception for debugging
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plant Identifier'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _image == null
//                   ? Container(
//                       height: 300,
//                       color: Colors.grey[200],
//                       child:
//                           Icon(Icons.image, size: 100, color: Colors.grey[400]),
//                     )
//                   : Image.file(_image!, height: 300, fit: BoxFit.cover),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _getImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text('Camera'),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _getImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo_library),
//                     label: const Text('Gallery'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _image == null ? null : _identifyPlant,
//                 child: const Text('Identify Plant'),
//               ),
//               const SizedBox(height: 16),
//               _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : Text(
//                       _result,
//                       style: const TextStyle(fontSize: 16),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlantIdentifier extends StatefulWidget {
  const PlantIdentifier({super.key});

  @override
  _PlantIdentifierPageS createState() => _PlantIdentifierPageS();
}

class _PlantIdentifierPageS extends State<PlantIdentifier> {
  File? _image;
  final Map<String, String> _plantInfo = {};
  bool _isLoading = false;
  String _errorMessage = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _plantInfo.clear();
        _errorMessage = '';
      }
    });
  }

  Future<void> _identifyPlant() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final apiKey = '${dotenv.env["PLANTFINDKEY"]}';
    const apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

    try {
      final bytes = await _image!.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': '''
                  Identify this plant and provide detailed information about it. If you can't identify the plant, please state that clearly.
                  If identified, provide information in this format:
                  Name:
                  Scientific Classification:
                  Life Cycle:
                  Interesting Facts:
                  Growing Conditions:
                  Care Guide:
                  Uses:
                  '''
                },
                {
                  'inline_data': {
                    'mime_type': 'image/jpeg',
                    'data': base64Image,
                  }
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['candidates'][0]['content']['parts'][0]['text'];
        _parsePlantInfo(result);
      } else {
        throw Exception('Failed to load plant information');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _parsePlantInfo(String result) {
    _plantInfo.clear();
    final lines = result.split('\n');
    String currentKey = '';

    for (final line in lines) {
      if (line.contains(':')) {
        final parts = line.split(':');
        currentKey = parts[0].trim();
        _plantInfo[currentKey] = parts.sublist(1).join(':').trim();
      } else if (line.trim().isNotEmpty) {
        _plantInfo[currentKey] =
            '${_plantInfo[currentKey] ?? ''}\n${line.trim()}';
      }
    }

    if (_plantInfo.isEmpty ||
        !_plantInfo.containsKey('Name') ||
        _plantInfo['Name']!.isEmpty) {
      _errorMessage = "Unable to identify the plant. Please try another image.";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Identifier'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _image == null
                  ? Container(
                      height: 300,
                      color: Colors.grey[200],
                      child:
                          Icon(Icons.image, size: 100, color: Colors.grey[400]),
                    )
                  : Image.file(_image!, height: 300, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _image == null ? null : _identifyPlant,
                child: const Text('Identify Plant'),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Text(_errorMessage,
                          style: const TextStyle(color: Colors.red))
                      : _buildPlantInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantInfo() {
    if (_plantInfo.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _plantInfo['Name'] ?? 'Identified Plant',
        ),
        const SizedBox(height: 16),
        _buildInfoSection('Scientific Classification'),
        _buildInfoSection('Life Cycle'),
        _buildInfoSection('Interesting Facts'),
        _buildInfoSection('Growing Conditions'),
        _buildInfoSection('Care Guide'),
        _buildInfoSection('Uses'),
      ],
    );
  }

  Widget _buildInfoSection(String title) {
    if (!_plantInfo.containsKey(title) || _plantInfo[title]!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(_plantInfo[title]!),
        const SizedBox(height: 16),
      ],
    );
  }
}
