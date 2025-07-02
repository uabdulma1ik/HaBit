import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSound = true;
  bool isDark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 36.0),
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Settings',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 80,
            right: 80,
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 30,
                  children: [
                    Text(
                      'Sound effect',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFFFFB347),
                      inactiveThumbColor: const Color(0xFFFFB347),
                      inactiveTrackColor: Colors.white,
                      // Yangi propertylar
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      splashRadius: 0,
                      // Chegaralar uchun
                      thumbColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        return const Color(0xFFFFB347);
                      }),
                      trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            // ignore: deprecated_member_use
                            return const Color(0xFFFFB347).withOpacity(0.5);
                          }
                          // ignore: deprecated_member_use
                          return const Color(0xFFFFB347).withOpacity(0.5);
                        },
                      ),
                      value: isSound,
                      onChanged: (value) {
                        setState(() {
                          isSound = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  spacing: 46,
                  children: [
                    Text(
                      'Dark Mode',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFFFFB347),
                      inactiveThumbColor: const Color(0xFFFFB347),
                      inactiveTrackColor: Colors.white,
                      // Yangi propertylar
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      splashRadius: 0,
                      // Chegaralar uchun
                      thumbColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        return const Color(0xFFFFB347);
                      }),
                      trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            // ignore: deprecated_member_use
                            return const Color(0xFFFFB347).withOpacity(0.5);
                          }
                          // ignore: deprecated_member_use
                          return const Color(0xFFFFB347).withOpacity(0.5);
                        },
                      ),
                      value: isDark,
                      onChanged: (value) {
                        setState(() {
                          isDark = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  spacing: 30,
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/lock_black.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Reset Password',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
