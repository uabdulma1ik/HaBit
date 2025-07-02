import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/screens/widgets/custom_dialog/custom_dialog_open_smth.dart';
import 'package:habit/screens/home/widgets/colour_filter_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _showImgDialog(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.zero,
            content: CustomDialogOpenSmth(
              topPath: 'assets/icons/keyboard_black.png',
              topString: 'Add note',
              bottomPath: 'assets/icons/check_box_black.png',
              bottomString: 'Add to-do',
              onTopFunc: () {
                context.pop();
                context.push('/addNote');
              },
              onBottomFunc: () {
                context.pop();
              },
            ),
          );
        },
      );
    }

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
              onPressed: () {
                _showImgDialog(context);
              },
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
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ColourFilterDialog(),
                  );
                },
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Center(
                    child: Image.asset(
                      'assets/images/color_lens.png',
                      fit: BoxFit.cover,
                    ),
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
                  height: 200,
                  width: 198,
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
