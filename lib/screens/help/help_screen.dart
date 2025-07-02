import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFB347),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: [
            Positioned(
              height: 251,
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color(0xFFFFB347),
                child: Stack(
                  children: [
                    Positioned(
                      top: 46,
                      left: 36,
                      child: Text(
                        'Help',
                        style: GoogleFonts.roboto(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 60,
                      child: Text(
                        'User Guide',
                        style: GoogleFonts.roboto(
                          fontSize: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 281,
              left: 50,
              right: 50,
              child: Column(
                spacing: 20,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB347),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/note_white.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notes',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Tap to view',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB347),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/search_image_white.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OCR',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Tap to view',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB347),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/lock.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reset Password',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Tap to view',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
