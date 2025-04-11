import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_app/Controller/Providers/HomeScreen_provider.dart';
import 'package:student_app/View/HomeScreen/HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Force landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, // Allow landscape left
    DeviceOrientation.landscapeRight, // Allow landscape right
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomescreenProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansArabicTextTheme(textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        // Clamp text scale factor to prevent excessive scaling
        final mediaQueryData = MediaQuery.of(context);
        final clampedTextScaler = mediaQueryData.textScaler.clamp(
          minScaleFactor: 1.0, // Minimum scale factor (usually 1.0)
          maxScaleFactor: 1.0, // Maximum scale factor (adjust as needed)
        );

        return MediaQuery(
          // Override textScaler with the clamped value
          data: mediaQueryData.copyWith(textScaler: clampedTextScaler),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
      home: FlutterSplashScreen(
        duration: const Duration(milliseconds: 2000),
        nextScreen: HomeScreen(),
        splashScreenBody: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/SplashScreen.png"),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
