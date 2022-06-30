import 'package:flutter_application_eval/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {
  Database? db;

  Future initialiseDatabase() async {
    var databasePath = await getDatabasesPath();

    db = await openDatabase(join(databasePath, 'fluttereval.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE notes (
        id     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        titre  TEXT NOT NULL, 
        date   TEXT NOT NULL,
        texte  TEXT NOT NULL,
        image  TEXT NOT NULL)''');
    });
  }

  Future<Note> addNote(Note note) async {
    await initialiseDatabase();
    await db?.insert('notes', note.toJson());
    return Note(
        titre: note.titre,
        date: note.date,
        texte: note.texte,
        image: note.image);
  }

  Future<List<Note>> getAllNotes() async {
    List<Note> noteResult = [];
    await initialiseDatabase();
    var result = await db!.query('notes');
    for (var note in result) {
      noteResult.add(Note.fromJson(note));
    }
    return noteResult;
  }
}
