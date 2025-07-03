import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  int color;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });
}




class NoteHiveService {
  static const String boxName = 'notesBox';

  Future<void> addNote(Note note) async {
    final box = await Hive.openBox<Note>(boxName);
    await box.put(note.id, note);
  }

  Future<List<Note>> getAllNotes() async {
    final box = await Hive.openBox<Note>(boxName);
    return box.values.toList();
  }

  Future<void> updateNote(Note note) async {
    final box = await Hive.openBox<Note>(boxName);
    await box.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    final box = await Hive.openBox<Note>(boxName);
    await box.delete(id);
  }

  Future<void> clearNotes() async {
    final box = await Hive.openBox<Note>(boxName);
    await box.clear();
  }
}
