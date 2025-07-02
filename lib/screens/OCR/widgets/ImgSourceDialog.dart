import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImgSourceDialog extends StatelessWidget {
  final VoidCallback onTapGallery;
  final VoidCallback onTapCamera;

  const ImgSourceDialog({
    super.key,
    required this.onTapGallery,
    required this.onTapCamera,
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
            crossAxisAlignment: CrossAxisAlignment.start, // <-- CHAPGA HIZALASH
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
                onTap: onTapCamera,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/photo_camera_black.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Take photo',
                      style: TextStyle(
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
                onTap: onTapGallery,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/photo_library_black.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Choose from Gallery',
                      style: TextStyle(
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
