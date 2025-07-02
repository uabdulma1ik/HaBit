import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    context.pushReplacement('/wrapper');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFFB347),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFB347),
        body: Stack(
          children: [
            Positioned(
              top: 165,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 135,
                    width: 135,
                    child: Image.asset(
                      'assets/images/haBit_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Habit Note',
                    style: GoogleFonts.fugazOne(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Text(
                textAlign: TextAlign.center,
                '© Copyright HABIT 2021. All rights reserved',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
