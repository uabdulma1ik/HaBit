import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int color;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    required this.isCompleted,
  });

  @override
  List<Object> get props => [
    id,
    title,
    createdAt,
    updatedAt,
    color,
    isCompleted,
  ];


}
