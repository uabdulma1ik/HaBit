part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotesEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final Note note;

  const AddNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  const UpdateNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String id;

  const DeleteNoteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SearchNotesEvent extends NoteEvent {
  final String query;

  const SearchNotesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SelectColorEvent extends NoteEvent {
  final int color;

  const SelectColorEvent(this.color);

  @override
  List<Object> get props => [color];
}

class ShowColorPickerEvent extends NoteEvent {
  final bool showPicker;

  const ShowColorPickerEvent(this.showPicker);

  @override
  List<Object> get props => [showPicker];
}

class ToggleGridViewEvent extends NoteEvent {
  final bool isGridView;

  const ToggleGridViewEvent(this.isGridView);

  @override
  List<Object> get props => [isGridView];
}
