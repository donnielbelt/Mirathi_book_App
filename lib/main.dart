import 'package:flutter/material.dart';
import 'package:mirathi_book_app/themes/themes.dart';
import 'package:mirathi_book_app/views/OnBoardings/onboarding_screen.dart';
import 'package:mirathi_book_app/views/OnBoardings/splash_screen.dart';

void main() {
  runApp(const MyApp());
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
