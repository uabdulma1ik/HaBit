import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit/data/note_model.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  CollectionReference? notesCollection;
  List<Note> _allNotes = [];
  StreamSubscription<User?>? _authSubscription;

  NoteBloc() : super(NotesLoadingState()) {
    _initializeAuth();

    on<LoadNotesEvent>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<SelectColorEvent>(_onSelectColor);
    on<ShowColorPickerEvent>(_onShowColorPicker);
    on<ToggleGridViewEvent>(_onToggleGridView);
  }

  void _onToggleGridView(ToggleGridViewEvent event, Emitter<NoteState> emit) {
    if (state is NotesLoadedState) {
      final currentState = state as NotesLoadedState;
      emit(
        NotesLoadedState(
          currentState.notes,
          searchQuery: currentState.searchQuery,
         
          showColorPicker: currentState.showColorPicker,
          selectedColor: currentState.selectedColor,
          isGridView: event.isGridView,
        ),
      );
    }
  }

  void _initializeAuth() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
      User? user,
    ) {
      if (user != null) {
        notesCollection = FirebaseFirestore.instance
            .collection('notes')
            .doc(user.uid)
            .collection('user_notes');

        add(LoadNotesEvent());
      } else {
        notesCollection = null;
        _allNotes.clear();
      }
    });
  }

  Future<void> _onLoadNotes(
    LoadNotesEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      emit(NotesLoadingState());
      final snapshot = await notesCollection!
          .orderBy('createdAt', descending: true)
          .get();

      _allNotes = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          title: data['title'] ?? '',
          note: data['note'] ?? '',
          createdAt: data.containsKey('createdAt')
              ? (data['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
          updatedAt: data.containsKey('updatedAt')
              ? (data['updatedAt'] as Timestamp).toDate()
              : DateTime.now(),
          color: data.containsKey('color') ? data['color'] : 0xFFFFFFFF,
        );
      }).toList();

      emit(
        NotesLoadedState(
          _allNotes,
          selectedColor: _allNotes.isNotEmpty
              ? _allNotes.first.color
              : 0xFFFFFFFF,
        ),
      );
    } catch (e) {
      emit(NotesErrorState('Failed to load notes: $e'));
    }
  }

  Future<void> _onSelectColor(
    SelectColorEvent event,
    Emitter<NoteState> emit,
  ) async {
    if (state is! NotesLoadedState) {
      emit(NotesLoadedState(const [], selectedColor: event.color));
      return;
    }

    final currentState = state as NotesLoadedState;
    emit(
      NotesLoadedState(
        currentState.notes,
        searchQuery: currentState.searchQuery,
       
        showColorPicker: currentState.showColorPicker,
        selectedColor: event.color,
      ),
    );
  }

  Future<void> _onShowColorPicker(
    ShowColorPickerEvent event,
    Emitter<NoteState> emit,
  ) async {
    if (state is! NotesLoadedState) return;

    final currentState = state as NotesLoadedState;
    emit(
      NotesLoadedState(
        currentState.notes,
        searchQuery: currentState.searchQuery,
        showColorPicker: event.showPicker,
        selectedColor: currentState.selectedColor,
      ),
    );
  }



  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    try {
      final now = DateTime.now();
      await notesCollection!.add({
        'title': event.note.title,
        'note': event.note.note,
        'color': event.note.color,
        'createdAt': now,
        'updatedAt': now,
      });

      add(LoadNotesEvent());
    } catch (e) {
      emit(NotesErrorState('Failed to add note: $e'));
    }
  }

  Future<void> _onUpdateNote(
    UpdateNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      final now = DateTime.now();
      await notesCollection!.doc(event.note.id).update({
        'title': event.note.title,
        'note': event.note.note,
        'color': event.note.color,
        'updatedAt': now,
      });

      add(LoadNotesEvent());
    } catch (e) {
      emit(NotesErrorState('Failed to update note: $e'));
    }
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      await notesCollection!.doc(event.id).delete();
      add(LoadNotesEvent());
    } catch (e) {
      emit(NotesErrorState('Failed to delete note: $e'));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
