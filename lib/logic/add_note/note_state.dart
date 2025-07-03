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
  final bool isSearching;
  final bool showColorPicker;
  final int selectedColor;

  const NotesLoadedState(
    this.notes, {
    this.searchQuery,
    this.isSearching = false,
    this.showColorPicker = false,
    this.selectedColor = 0xFFFFFFFF,
  });

  @override
  List<Object> get props => [
    notes,
    searchQuery ?? '',
    isSearching,
    showColorPicker,
    selectedColor,
  ];
}

class NotesErrorState extends NoteState {
  final String message;

  const NotesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
