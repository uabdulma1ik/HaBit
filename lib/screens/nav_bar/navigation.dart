import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/logic/navigation/navigation_bar_bloc.dart';
import 'package:habit/logic/navigation/navigation_bar_event.dart';
import 'package:habit/logic/navigation/navigation_bar_state.dart';
import 'package:habit/screens/OCR/ocr_screen.dart';
import 'package:habit/screens/help/help_screen.dart';
import 'package:habit/screens/home/home_screen.dart';
import 'package:habit/screens/myProfile/myProfile_screen.dart';
import 'package:indicator_bottom_navigationbar/indicator_bottom_navigationbar.dart';


class Navigation extends StatelessWidget {
  Navigation({super.key});

  static final List<IconLabel> iconLabels = [
    IconLabel(Icons.note_outlined, 'Notes'),
    IconLabel(Icons.image_outlined, 'OCR'),
    IconLabel(Icons.person_outline, 'Me'),
    IconLabel(Icons.help_outline, 'Help'),
  ];

  final List<Widget> pages = const [
    HomeScreen(),
    OcrScreen(),
    MyprofileScreen(),
    HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.currentIndex],
          backgroundColor: Colors.white,
          bottomNavigationBar: IndicatorBottomNavigationbar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(ChangeTabEvent(index));
            },
            iconLabels: iconLabels,
            selectedItemColor: const Color(0xFFFFB347),
            unselectedItemColor: Colors.grey[700]!,
            backgroundColor: Colors.white,
            indicatorHeight: 2.5,
            indicatorWidth: 70,
          ),
        );
      },
    );
  }
}
