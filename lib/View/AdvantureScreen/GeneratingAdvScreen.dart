// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/Controller/FlutterTTS.dart';

import 'package:student_app/Controller/GeminiImage.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/GeneratingImage.dart';
import 'package:student_app/Controller/spans.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class Generatingadvscreen extends StatefulWidget {
  final String prompt;

  const Generatingadvscreen({
    Key? key,
    required this.prompt,
  }) : super(key: key);

  @override
  State<Generatingadvscreen> createState() => _GeneratingadvscreenState();
}

class _GeneratingadvscreenState extends State<Generatingadvscreen> {
  TTSService speak = TTSService();

  List<bool> numberBoxSelections = List.generate(7, (index) => false);
  late Future<void> genai;
  bool _isGenerating = true;
  String genais = '';
  String titlename = '';
  bool _isGeneratingtext = true;
  Uint8List? imageBytes;
  bool loading = true;
  String? gentext = '';

  @override
  void dispose() {
    speak.stop(); // Stop TTS when the widget is disposed

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Start generating image immediately when screen loads
    genai = _generatetext();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _generatetext() async {
    try {
      GeminiTextService _gemin = new GeminiTextService();

      final textss = await _gemin.generateText(widget.prompt);
      print(textss);
      genais = textss!;
      titlename = (await _gemin.generateText(genais +
          '  أكتب بس العنوان بدون القول أي شي العناون فقط و لا حتي تكتب كلمة عنوان القصة أسم القصة فقط'))!;
      gentext = await _gemin.generateText(genais +
          '\n make this advanctivere as image prompt generation write it in english without saying anything or after only prompit ');

      _generateImageOnLoad();

      setState(() => _isGeneratingtext = false);
      return genai;
    } catch (e) {
      setState(() => _isGeneratingtext = false);
      throw e; // Re-throw to be caught by FutureBuilder
    }
  }

  Future<void> _generateImageOnLoad() async {
    setState(() {
      loading = true;
    });
    GeminiImageService _imageGenerator = new GeminiImageService();

    print('heloo--' + gentext!);
    gentext = 'generate an image about: ' + gentext!;
    final result = await _imageGenerator.generateImage(gentext!);

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
          scrolledUnderElevation: 0.0,
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
                        setState(() {
                          speak.stop();
                          _isGenerating = true;
                          genais = '';
                          titlename = '';
                          _isGeneratingtext = true;
                          imageBytes = null;
                          loading = true;
                        });

                        genai = _generatetext();
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
                "Assets/Advantare.png",
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
                height: 80,
              ),
              Expanded(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            height: MediaQuery.of(context).size.height / 1.2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Assets/Greenbox.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.058,
                                  right: 20,
                                  left: 20,
                                  top: 20),
                              child: InkWell(
                                onLongPress: () {
                                  _copyToClipboard(genais);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffedf2d7),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: _isGeneratingtext
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : SingleChildScrollView(
                                          child: Center(
                                              child: buildStyledText(genais))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height / 12,
                          right: MediaQuery.of(context).size.width / 2.4,
                          width: 75,
                          height: 75,
                          child: InkWell(
                              onTap: () async {
                                await speak.speakText(genais);
                              },
                              child: Image.asset("Assets/listen.png")),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            height: MediaQuery.of(context).size.height / 1.2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Assets/Greenbox.png"),
                                  fit: BoxFit.fill),
                            ),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.058,
                                right: 20,
                                left: 20,
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.memory(
                                            imageBytes!,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Center(
                                          child: Text("Failed to load image")),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height / 12,
                          right: MediaQuery.of(context).size.width / 2.4,
                          width: 65,
                          height: 65,
                          child: InkWell(
                              onTap: () async {
                                final imageService = ImageGenerationService(
                                  apiKey:
                                      'sk-8O39BNVMc5JJf9ppRs2456ieucZtT3wzBgbGQ67zYj5ZfhPJ',
                                  imageAIStyle: ImageAIStyle
                                      .digitalPainting, // optional style
                                );

                                await imageService.saveImageWithPopupPicker(
                                    context, imageBytes!);
                              },
                              child: Image.asset("Assets/Download_.png")),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
