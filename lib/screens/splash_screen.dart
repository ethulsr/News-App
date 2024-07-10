// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:news_today/screens/main_screen.dart';
import 'package:news_today/utils/apptheme.dart';
import 'package:news_today/utils/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  void _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme.secondaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/NewsLogo5.png',
              width: 150,
            ),
            const SizedBox(width: 10),
            ModifiedTexts(
              text: 'Today',
              color: Colors.yellow,
              size: 45,
              shadows: [],
            ),
          ],
        ),
      ),
    );
  }
}
