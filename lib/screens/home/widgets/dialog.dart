import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit/screens/widgets/custom_dialog/custom_dialog_open_smth.dart';

class ShowImageDialog extends StatelessWidget {
  const ShowImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      contentPadding: EdgeInsets.zero,
      content: CustomDialogOpenSmth(
        topPath: 'assets/icons/keyboard_black.png',
        topString: 'Add note',
        bottomPath: 'assets/icons/check_box_black.png',
        bottomString: 'Add to-do',
        onTopFunc: () {
          context.pop();
          context.push('/note');
        },
        onBottomFunc: () {
          context.pop();
          // context.push('/todo');
        },
      ),
    );
  }
}
