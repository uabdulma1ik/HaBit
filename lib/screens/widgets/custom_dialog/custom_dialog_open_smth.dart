import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogOpenSmth extends StatelessWidget {
  final VoidCallback onTopFunc;
  final VoidCallback onBottomFunc;

  final String topString;
  final String bottomString;

  final String topPath;
  final String bottomPath;

  const CustomDialogOpenSmth({
    super.key,
    required this.onTopFunc,
    required this.onBottomFunc,
    required this.topString,
    required this.bottomString,
    required this.topPath,
    required this.bottomPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 164,
      width: MediaQuery.of(context).size.width * 0.8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'New',
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onBottomFunc,
                child: Row(
                  children: [
                    Image.asset(
                      bottomPath,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      bottomString,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: onTopFunc,
                child: Row(
                  children: [
                    Image.asset(
                      topPath,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      topString,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
