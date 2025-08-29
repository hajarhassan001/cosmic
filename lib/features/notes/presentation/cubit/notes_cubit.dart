import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cosmic/features/notes/data/remote/notes_firebase.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesService _service;
  final String userId;

  NotesCubit(this._service, this.userId) : super(NotesInitial());

  Future<void> loadNotes() async {
    emit(NotesLoading());
    try {
      final notes = await _service.loadNotes(userId);
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> addNote(String planetName, String note) async {
    try {
      await _service.addNote(planetName, note);
      loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> removeNote(String noteId) async {
    try {
      await _service.removeNote(userId, noteId);
      loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
