import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: const Color(0xFFFFB347),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(-4, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFFFFB347),
              elevation: 0,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 45),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Notes',
              style: GoogleFonts.roboto(
                fontSize: 36,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: Image.asset(
                    'assets/images/color_lens.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: Image.asset(
                    'assets/icons/grid_view.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 209,
                  width: 207,
                  child: Image.asset(
                    'assets/images/rafiki.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Create your first note !',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
