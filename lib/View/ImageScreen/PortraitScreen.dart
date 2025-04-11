import 'dart:typed_data';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:student_app/Controller/GeminiImage.dart';
import 'package:student_app/Controller/GeneratingImage.dart';

class Portraitscreen extends StatefulWidget {
  final String prompt;
  final ImageAIStyle imageAIStyle;

  const Portraitscreen({
    Key? key,
    required this.prompt,
    required this.imageAIStyle,
  }) : super(key: key);

  @override
  State<Portraitscreen> createState() => _PortraitscreenState();
}

class _PortraitscreenState extends State<Portraitscreen> {
  Uint8List? imageBytes;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _generateImageOnLoad();
  }

  Future<void> _generateImageOnLoad() async {
    setState(() {
      loading = true;
    });
    GeminiImageService imageGenerator = new GeminiImageService();
    var gentext = 'generate an image about: ${widget.prompt}';

    final result = await imageGenerator.generateImage(gentext);

    setState(() {
      imageBytes = result;
      loading = false;
    });
  }

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
              height: 20,
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Greenbox.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.067,
                            right: 20,
                            left: 25,
                            top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffedf2d7),
                          ),
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
                    width: 75,
                    height: 75,
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
                        child: Image.asset("Assets/listen.png")),
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
