part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NotesLoadingState extends NoteState {}

class NotesLoadedState extends NoteState {
  final List<Note> notes;
  final String? searchQuery;
  final bool showColorPicker;
  final int selectedColor;
  final bool isGridView;

  const NotesLoadedState(
    this.notes, {
    this.searchQuery,

    this.showColorPicker = false,
    this.selectedColor = 0xFFFFFFFF,
    this.isGridView = false,
  });

  @override
  List<Object> get props => [
    notes,
    searchQuery ?? '',

    showColorPicker,
    selectedColor,
    isGridView,
  ];
}

class NotesErrorState extends NoteState {
  final String message;

  const NotesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
