import 'package:flutter/material.dart';
import 'package:mirathi_book_app/views/OnBoardings/onboarding_screen.dart';

import '../../reusable_widget/Buttons/custom_button.dart';

class SplashScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const SplashScreen({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Get Started",
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}