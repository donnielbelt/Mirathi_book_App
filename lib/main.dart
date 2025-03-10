import 'package:flutter/material.dart';
import 'package:mirathi_book_app/themes/themes_model.dart';
import 'package:mirathi_book_app/views/book_read.dart';
import 'package:provider/provider.dart';
import 'package:mirathi_book_app/themes/themes.dart';
import 'package:mirathi_book_app/views/OnBoardings/onboarding_screen.dart';
import 'package:mirathi_book_app/views/OnBoardings/splash_screen.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Pspdfkit.initialize();
  } catch (e) {
    print("PSPDFKit initialization failed: $e");
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home:  SplashScreen(
        imagePath: 'assets/images/splash_image.png',
        title: 'Urithi na Mirathi',
        subtitle: 'Your Gateway to Knowledge                           \nAbout Inheritance',
),
    );
  }
}
