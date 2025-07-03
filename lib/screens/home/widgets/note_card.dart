import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/data/note_model.dart';

import 'package:timeago/timeago.dart' as timeago;

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onPressed;
  const NoteCard({super.key, required this.note, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    DateTime displayTime = note.updatedAt.isAfter(note.createdAt)
        ? note.updatedAt
        : note.createdAt;

    String formattedDateTime = timeago.format(displayTime);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(top: 12, right: 17, bottom: 7, left: 17),
        decoration: BoxDecoration(
          color: Color(note.color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              note.title,
              style: GoogleFonts.roboto(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                formattedDateTime,
                style: GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
