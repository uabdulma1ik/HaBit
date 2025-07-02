import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int color;

  const Note({
    required this.id,
    required this.title,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
  });

  @override
  List<Object?> get props => [id, title, note, createdAt, updatedAt, color];
}
