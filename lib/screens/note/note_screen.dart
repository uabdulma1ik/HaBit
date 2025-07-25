import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/data/note_model.dart';
import 'package:habit/logic/note/note_bloc.dart';
import 'package:habit/screens/note/widgets/color_picker_dialog.dart';

class AddNoteScreen extends StatefulWidget {
  final Note note;
  const AddNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late Note note;
  late TextEditingController titleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    note = widget.note;
    titleController = TextEditingController(text: note.title);
    noteController = TextEditingController(text: note.note);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialColor = note.color == 0xFFFFFFFF
          ? note.color
          : Colors.white.toARGB32();
      context.read<NoteBloc>().add(SelectColorEvent(initialColor));
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  final selectedColor = state is NotesLoadedState
                      ? state.selectedColor
                      : (note.color == 0xFFFFFFFF
                            ? Colors.red.toARGB32()
                            : note.color);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (titleController.text.trim() !=
                                      note.title.trim() ||
                                  noteController.text.trim() !=
                                      note.note.trim() ||
                                  selectedColor != note.color) {
                                final newNote = Note(
                                  id: note.id,
                                  title: titleController.text.trim(),
                                  note: noteController.text.trim(),
                                  createdAt: note.id.isEmpty
                                      ? DateTime.now()
                                      : note.createdAt,
                                  updatedAt: DateTime.now(),
                                  color: selectedColor,
                                );

                                if (note.id.isEmpty) {
                                  context.read<NoteBloc>().add(
                                    AddNoteEvent(newNote),
                                  );
                                } else {
                                  context.read<NoteBloc>().add(
                                    UpdateNoteEvent(newNote),
                                  );
                                }
                              }
                              context.pop();
                            },
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: SvgPicture.asset(
                                'assets/icons/arrow_back_24px_outlined.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            note.id.isEmpty ? 'Add Note' : 'Edit Note',
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ColorPickerDialog(
                                    noteId: note.id.isNotEmpty ? note.id : null,
                                  );
                                },
                              );
                            },
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset(
                                'assets/icons/more_vert_black.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: titleController,
                        textCapitalization: TextCapitalization.words,
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 42,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: GoogleFonts.nunito(
                            color: Colors.black54,
                            fontSize: 42,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: noteController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type something...',
                          hintStyle: GoogleFonts.nunito(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
