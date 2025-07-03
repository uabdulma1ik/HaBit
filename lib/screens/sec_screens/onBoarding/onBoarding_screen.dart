import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/data/onBoarding_model.dart';
import 'package:habit/logic/onBoarding/onboarding_bloc.dart';
import 'package:habit/logic/onBoarding/onboarding_event.dart';
import 'package:habit/logic/onBoarding/onboarding_state.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingModel> pages = [
      OnboardingModel(
        welcomeText: 'WELCOME TO',
        welcomeText2: 'HaBit Note',
        imagePath: 'assets/svg/amico.svg',
        abooutText: 'Take Notes',
        abooutText2: "Quickly capture what's on your mind",
      ),
      OnboardingModel(
        imagePath: 'assets/images/cuate.png',
        abooutText: 'To-dos',
        abooutText2: 'List out your day-to-day tasks',
      ),
      OnboardingModel(
        imagePath: 'assets/images/amico.png',
        abooutText: 'Image to Text Converter',
        abooutText2: 'Upload your images and convert to text',
      ),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  top: 46,
                  left: 36,
                  child: GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/svg/menu_icon.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    context.read<OnboardingBloc>().add(PageChangedEvent(index));
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Stack(
                      children: [
                        Positioned(
                          top: 109,
                          left: 39,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (page.welcomeText != null &&
                                  page.welcomeText!.isNotEmpty)
                                Text(
                                  page.welcomeText!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                  ),
                                ),
                              Text(
                                page.welcomeText2 ?? '',
                                style: GoogleFonts.fugazOne(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 195,
                          left: 36,
                          right: 36,
                          child: SizedBox(
                            height: 340,
                            width: 340,
                            child: page.imagePath.endsWith('.svg')
                                ? SvgPicture.asset(
                                    page.imagePath,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    page.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),

                        Positioned(
                          top: 539,
                          left: 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                page.abooutText,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                page.abooutText2,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 645,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length,
                              (dotIndex) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                height: 8,
                                width: state.currentIndex == dotIndex ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: state.currentIndex == dotIndex
                                      ? const Color(0xFFFFB347)
                                      // ignore: deprecated_member_use
                                      : Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                Positioned(
                  top: 695,
                  left: 36,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push('/createAccount');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 343,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB347),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Text(
                            'CREATE ACCOUNT',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          context.push('/logIn');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 343,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Text(
                            'LOG IN',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: const Color(0xFFFFB347),
                            ),
                          ),
                        ),
                      ),
                    ],
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
