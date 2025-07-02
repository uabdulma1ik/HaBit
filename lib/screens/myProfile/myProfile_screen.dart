import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/screens/widgets/customDialog.dart';
import 'package:habit/screens/widgets/customSnackbar.dart/customSnackbar.dart';
import 'package:habit/services/auth_service/auth_service.dart';

class MyprofileScreen extends StatefulWidget {
  const MyprofileScreen({super.key});

  @override
  State<MyprofileScreen> createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  String? displayName;
  String? email;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      AuthService().getUserData(user.uid).then((userData) {
        setState(() {
          displayName = userData['displayName'];
          email = userData['email'];
        });
      });
    }
  }

  void logOut() async {
    try {
      await AuthService().signOut();

      if (mounted) {
        context.pushReplacement('/onBoarding');
      }
    } on FirebaseAuthException catch (e) {
      print('Sign out error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
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
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Stack(
                  children: [
                    Positioned(
                      top: 46,
                      left: 36,
                      child: Text(
                        'Me',
                        style: GoogleFonts.roboto(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.asset(
                              'assets/images/profile_image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$displayName',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '$email',
                                style: GoogleFonts.roboto(
                                  fontSize: 15.5,
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
              ),
            ),
            const Positioned(
              top: 251,
              left: 0,
              right: 0,
              child: Divider(
                color: Color.fromARGB(255, 0, 0, 0),
                thickness: 0.7,
                height: 1,
              ),
            ),
            Positioned(
              top: 278,
              left: 60,
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 30,
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/icons/archive_black.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Archive notes',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/settings');
                    },
                    child: Row(
                      spacing: 30,
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/settings_black.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Settings',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/about');
                    },
                    child: Row(
                      spacing: 30,
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/info_black.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'About',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 424,
              left: 36,
              right: 36,
              child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => MyCustomDialog(
                    title: 'LOG OUT',
                    message: 'Do you really want this action?',
                    cancelText: 'No',
                    confirmText: 'Yes',
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                    onConfirm: () {
                      Navigator.of(context).pop();
                      logOut();
                      CustomSnackbar(
                        context: context,
                        message: 'Logged Out',
                      ).show();
                    },
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB347),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/icons/logout_black.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'LOG OUT',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
