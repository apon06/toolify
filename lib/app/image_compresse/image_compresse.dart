// // ignore_for_file: use_build_context_synchronously

// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class ImageCompresse extends StatefulWidget { 
//   const ImageCompresse({super.key});

//   @override
//   ImageCompresseState createState() => ImageCompresseState();
// }

// class ImageCompresseState extends State<ImageCompresse> {
//   List<File> _images = [];
//   List<File> _compressedImages = [];
//   double _quality = 50.0;
//   bool _isLoading = false;
//   final ScreenshotController _screenshotController = ScreenshotController();

//   Future<void> _pickImages() async {
//     final picker = ImagePicker();
//     final pickedFiles = await picker.pickMultiImage();

//     setState(() {
//       _images = pickedFiles.map((file) => File(file.path)).toList();
//       _compressedImages.clear();
//     });
//   }

//   Future<void> _compressImages() async {
//     if (_images.isEmpty) return;

//     setState(() {
//       _isLoading = true;
//     });

//     List<File> compressedFiles = [];

//     for (var image in _images) {
//       final imageBytes = image.readAsBytesSync();
//       final compressedImageBytes = await FlutterImageCompress.compressWithList(
//         imageBytes,
//         quality: _quality.toInt(),
//       );

//       final directory = await getTemporaryDirectory();
//       final filePath =
//           '${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
//       final file = File(filePath);
//       await file.writeAsBytes(compressedImageBytes);

//       compressedFiles.add(file);
//     }

//     setState(() {
//       _compressedImages = compressedFiles;
//       _isLoading = false;
//     });
//   }

//   Future<void> _captureAndSave() async {
//     if (_compressedImages.isEmpty) return;

//     for (var i = 0; i < _compressedImages.length; i++) {
//       final imageFile = _compressedImages[i];
//       final imageBytes = await imageFile.readAsBytes();
//       final result =
//           await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes));

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(result != null
//               ? 'Image saved to gallery!'
//               : 'Failed to save image'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Compressor'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.download),
//             onPressed: _captureAndSave,
//           ),
//         ],
//       ),
//       body: Screenshot(
//         controller: _screenshotController,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Quality: ${_quality.toInt()}',
//                         style: const TextStyle(fontSize: 16)),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Slider(
//                         value: _quality,
//                         min: 0,
//                         max: 100,
//                         divisions: 100,
//                         label: _quality.toInt().toString(),
//                         onChanged: (value) {
//                           setState(() {
//                             _quality = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _pickImages,
//                     child: const Text('Pick Images'),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: _compressImages,
//                     child: const Text('Compress Images'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               if (_isLoading)
//                 const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               else
//                 Expanded(
//                   child: _compressedImages.isEmpty
//                       ? const Center(child: Text('No images to display'))
//                       : MasonryGridView.count(
//                           crossAxisCount: 4,
//                           itemCount: _compressedImages.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             final image = _compressedImages[index];
//                             return Card(
//                               elevation: 5,
//                               margin: const EdgeInsets.all(4),
//                               child: Image.file(
//                                 image,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                           mainAxisSpacing: 4.0,
//                           crossAxisSpacing: 4.0,
//                         ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';  // Updated import
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageCompresse extends StatefulWidget { 
  const ImageCompresse({super.key});

  @override
  ImageCompresseState createState() => ImageCompresseState();
}

class ImageCompresseState extends State<ImageCompresse> {
  List<File> _images = [];
  List<File> _compressedImages = [];
  double _quality = 50.0;
  bool _isLoading = false;
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      _images = pickedFiles.map((file) => File(file.path)).toList();
      _compressedImages.clear();
    });
  }

  Future<void> _compressImages() async {
    if (_images.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    List<File> compressedFiles = [];

    for (var image in _images) {
      final imageBytes = image.readAsBytesSync();
      final compressedImageBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: _quality.toInt(),
      );

      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(filePath);
      await file.writeAsBytes(compressedImageBytes);

      compressedFiles.add(file);
    }

    setState(() {
      _compressedImages = compressedFiles;
      _isLoading = false;
    });
  }

  Future<void> _captureAndSave() async {
    if (_compressedImages.isEmpty) return;

    for (var i = 0; i < _compressedImages.length; i++) {
      final imageFile = _compressedImages[i];
      final imageBytes = await imageFile.readAsBytes();
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(imageBytes),
        quality: _quality.toInt(),  // Optionally pass quality for the saved image
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['isSuccess'] == true
              ? 'Image saved to gallery!'
              : 'Failed to save image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Compressor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _captureAndSave,
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Quality: ${_quality.toInt()}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Slider(
                        value: _quality,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: _quality.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            _quality = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pickImages,
                    child: const Text('Pick Images'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _compressImages,
                    child: const Text('Compress Images'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                  child: _compressedImages.isEmpty
                      ? const Center(child: Text('No images to display'))
                      : MasonryGridView.count(
                          crossAxisCount: 4,
                          itemCount: _compressedImages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final image = _compressedImages[index];
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.all(4),
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
