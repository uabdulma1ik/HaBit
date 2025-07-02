import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColourFilterDialog extends StatelessWidget {
  const ColourFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFF9E9E),
      const Color(0xFFFFB347),
      const Color(0xFFFFF599),
      const Color(0xFF91F48F),
      const Color(0xFF9EFFFF),
      const Color(0xFFFD99FF),
      const Color(0xFFC4AFFF),
      const Color(0xFF7855FF),
      const Color(0xFFFCDDEC),
      const Color(0xFFF1F1F1),
      const Color(0xFFC4C4C4),
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                'Filter by colour',
                style: GoogleFonts.roboto(fontSize: 24),
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 80,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Reset', style: GoogleFonts.roboto(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            for (int i = 0; i < colors.length; i += 3)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    for (int j = i; j < i + 3 && j < colors.length; j++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: _colorButton(colors[j], context),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 0,
        child: Container(
          width: 80,
          height: 35,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Colors.black,
              width: 1.5, // Slightly thicker border for better visibility
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
