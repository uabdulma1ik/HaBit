import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/logic/my_profile/my_profile_bloc.dart';
import 'package:habit/logic/my_profile/my_profile_state.dart';
import 'package:habit/screens/widgets/custom_dialog/customDialog.dart';
import 'package:habit/screens/widgets/custom_snackbar/customSnackbar.dart';
import 'package:habit/services/auth_service/auth_service.dart';
import 'package:shimmer/shimmer.dart';


class MyprofileScreen extends StatelessWidget {
  const MyprofileScreen({super.key});

  void logOut(BuildContext context) async {
    try {
      await AuthService().signOut();
      if (context.mounted) {
        context.pushReplacement('/onBoarding');
        CustomSnackbar(context: context, message: 'Logged Out').show();
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
        body: BlocBuilder<MyProfileBloc, MyProfileState>(
          builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  height: 251,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
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
                              const SizedBox(width: 10),
                              state.isLoading
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 100,
                                            color: Colors.white,
                                            margin: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                          ),
                                          Container(
                                            height: 18,
                                            width: 180,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.displayName ?? 'User',
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.email ?? '',
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
                    color: Colors.black,
                    thickness: 0.7,
                    height: 1,
                  ),
                ),
                Positioned(
                  top: 278,
                  left: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/archive_black.png',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 30),
                          Text(
                            'Archive notes',
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => context.push('/settings'),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/settings_black.png',
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 30),
                            Text(
                              'Settings',
                              style: GoogleFonts.roboto(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => context.push('/about'),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/info_black.png',
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 30),
                            Text(
                              'About',
                              style: GoogleFonts.roboto(fontSize: 18),
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
                        onCancel: () => Navigator.of(context).pop(),
                        onConfirm: () {
                          Navigator.of(context).pop();
                          logOut(context);
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
                        children: [
                          Image.asset(
                            'assets/icons/logout_black.png',
                            height: 36,
                            width: 36,
                          ),
                          const SizedBox(width: 15),
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
            );
          },
        ),
      ),
    );
  }
}
