import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/logic/add_note/note_bloc.dart';

class ColorPickerDialog extends StatelessWidget {
  final String? noteId;

  ColorPickerDialog({super.key, this.noteId});

  final List<Color> colors = [
    const Color(0xFFFFFFFF),
    const Color(0xFFFF9E9E),
    const Color(0xFFFFF599),
    const Color(0xFF91F48F),
    const Color(0xFF9EFFFF),
    const Color(0xFFFD99FF),
    const Color(0xFFC4AFFF),
    const Color(0xFF7855FF),
    const Color(0xFFC4C4C4),
    const Color(0xFFFCDDEC),
    const Color(0xFFF1F1F1),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        final selectedColorIndex = colors.indexWhere(
          (color) => color.value == (state as NotesLoadedState).selectedColor,
        );

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.only(
              left: 35,
              top: 20,
              bottom: 20,
              right: 35,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (noteId != null) {
                      context.read<NoteBloc>().add(DeleteNoteEvent(noteId!));
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Go back to previous screen
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_outline,
                        size: 24,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Delete note',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade300, thickness: 1),
                const SizedBox(height: 16),
                Text(
                  'Select Colour',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<NoteBloc>().add(
                          SelectColorEvent(colors[index].value),
                        );
                        Navigator.pop(context); // Close dialog after selection
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors[index] == Colors.white
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            width: 1,
                          ),
                          boxShadow: selectedColorIndex == index
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: selectedColorIndex == index
                            ? Icon(
                                Icons.check,
                                color: colors[index] == Colors.white
                                    ? Colors.black54
                                    : Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
