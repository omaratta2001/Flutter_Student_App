import 'dart:convert';
import 'dart:typed_data';
import 'package:stability_image_generation/stability_image_generation.dart';

import 'package:flutter/material.dart';
import 'package:student_app/Controller/GeminiImage.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/GeneratingImage.dart';
import 'package:http/http.dart' as http;

class Landscreen extends StatefulWidget {
  final String prompt;
  final ImageAIStyle imageAIStyle;

  const Landscreen(
      {super.key, required this.prompt, required this.imageAIStyle});

  @override
  State<Landscreen> createState() => _LandscreenState();
}

class _LandscreenState extends State<Landscreen> {
  Uint8List? imageBytes;
  bool loading = false;

  // bool _isGenerating = true;
  // bool _isLoading = true;
  // String? _selectedStyle; // Store the selected style

  // List<String> _generatedImageUrls = [];

  // // @override
  // void initState() {
  //   super.initState();
  //   _imageGenerator =
  //       ImageGenerator(apiKey: 'AIzaSyAmDvjFXpnPQdmoMjGjXYsNREhzpFz6IM8');
  // }

  @override
  void initState() {
    super.initState();
    // Start generating image immediately when screen loads
    //_imageFuture = _generateImage();
    _generateImageOnLoad();
  }

  Future<void> _generateImageOnLoad() async {
    setState(() {
      loading = true;
    });
    GeminiImageService imageGenerator = new GeminiImageService();
    var gentext = '${widget.prompt}';

    final result = await imageGenerator.generateImage1(gentext, "16:9");

    setState(() {
      imageBytes = result;
      loading = false;
    });
  }

  // Future<Uint8List> _generateImage() async {
  //   try {
  //     final imageService = ImageGenerationService(
  //       apiKey: 'sk-vik6sy0OnWwz4V6pau2u6GEkyIkZR6MoJ46h31fzDSKt7RVA',
  //       imageAIStyle: widget.imageAIStyle, // optional style
  //     );
  //     final imageBytes = await imageService.generateImage(widget.prompt);
  //     setState(() => _isGenerating = false);
  //     _image = imageBytes;
  //     return imageBytes;
  //   } catch (e) {
  //     setState(() => _isGenerating = false);
  //     throw e; // Re-throw to be caught by FutureBuilder
  //   }
  // }

  // Future<void> _generateInitialImage() async {
  //   final imageUrl = await _imageGenerator.generateImage(widget.prompt,
  //       style: widget.prompt);
  //   if (imageUrl != null) {
  //     setState(() {
  //       _generatedImageUrl = imageUrl;
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to generate initial image.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Transform.translate(
              offset: Offset(-20, -20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _generateImageOnLoad();
                    },
                    child: Image.asset(
                      "Assets/Regenerate.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "Assets/Layer9.png",
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: Transform.translate(
            offset: Offset(-10, -15),
            child: Image.asset(
              "Assets/image.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 1.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Greenbox.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.06,
                            right: 20,
                            left: 20,
                            top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffedf2d7),
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(15),
                          //   child: Image.memory(
                          //     widget.imageBytes,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          //   child: FutureBuilder<Uint8List>(
                          //       future: _imageFuture,
                          //       builder: (context, snapshot) {
                          //         if (snapshot.connectionState ==
                          //             ConnectionState.waiting) {
                          //           return Center(
                          //             child: CircularProgressIndicator(),
                          //           );
                          //         } else if (snapshot.hasError) {
                          //           return Center(
                          //             child: Text(
                          //               'Error generating image: ${snapshot.error}',
                          //               style: TextStyle(color: Colors.red),
                          //             ),
                          //           );
                          //         } else if (snapshot.hasData) {
                          //           // Show the generated image
                          //           return ClipRRect(
                          //             borderRadius: BorderRadius.circular(15),
                          //             child: Image.memory(
                          //               snapshot.data!,
                          //               fit: BoxFit.cover,
                          //             ),
                          //           );
                          //         } else {
                          //           return Center(
                          //             child: Text("No image data available"),
                          //           );
                          //         }
                          //       }),
                          child: loading
                              ? Center(child: CircularProgressIndicator())
                              : imageBytes != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.memory(
                                        imageBytes!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Center(child: Text("Failed to load image")),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.095,
                    right: MediaQuery.of(context).size.width / 1.67,
                    width: 80,
                    height: 80,
                    child: InkWell(
                        onTap: () async {
                          final imageService = ImageGenerationService(
                            apiKey:
                                'sk-8O39BNVMc5JJf9ppRs2456ieucZtT3wzBgbGQ67zYj5ZfhPJ',
                            imageAIStyle:
                                ImageAIStyle.digitalPainting, // optional style
                          );

                          await imageService.saveImageWithPopupPicker(
                              context, imageBytes!);
                        },
                        child: Image.asset("Assets/Download_.png")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
