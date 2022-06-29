import 'package:flutter_application_eval/note.dart';
import 'package:flutter_application_eval/provider/noteprovider.dart';

class NoteRepository {
  final NoteProvider noteprovider = NoteProvider();

  Future<Note> addNote(Note note) async {
    return await noteprovider.addNote(note);
  }

  Future<List<Note>> getAllNotes() async {
    return await noteprovider.getAllNotes();
  }
}
