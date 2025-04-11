import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:file_picker/file_picker.dart';

class ImageGenerationService {
  final StabilityAI _ai = StabilityAI();
  final String apiKey;
  final ImageAIStyle imageAIStyle;

  ImageGenerationService({
    required this.apiKey,
    this.imageAIStyle = ImageAIStyle.digitalPainting,
  });

  /// Generate image from prompt
  Future<Uint8List> generateImage(String prompt) async {
    return await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: prompt,
    );
  }

  /// Save image to gallery
  Future<bool> saveImageToGallery(Uint8List imageBytes) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final result = await ImageGallerySaverPlus.saveImage(imageBytes);
    return result['isSuccess'] == true;
  }

  Future<bool> saveImageToGalleryWithLocation(Uint8List imageBytes) async {
    try {
      // Request permissions (Android)

      // Let user choose directory
      String? path = await FilePicker.platform.getDirectoryPath();
      print(path);
      if (path == null) return false; // User canceled

      // Save file
      final file =
          File('$path/image_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> saveImageWithPopupPicker(
      BuildContext context, Uint8List imageBytes) async {
    try {
      // Show dialog while waiting for file picker
      String? selectedPath = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Select Save Location"),
          content: FutureBuilder<String?>(
            future: FilePicker.platform.getDirectoryPath(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Loading folders..."),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              Navigator.of(context)
                  .pop(snapshot.data); // Close dialog with path
              return Container(); // Empty while resolving
            },
          ),
        ),
      );

      if (selectedPath == null || selectedPath.isEmpty) return false;

      // Save file
      final file = File(
          '$selectedPath/image_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image saved successfully!")),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save: ${e.toString()}")),
      );
      return false;
    }
  }
}
