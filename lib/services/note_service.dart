import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/note.dart';

class NoteService {
  static SharedPreferences? _prefs;
  static List<Note> notes = [];

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    await load();
  }

  static Future<void> load() async {
    final String? notesJson = _prefs?.getString('notes');
    if (notesJson != null) {
      final List<dynamic> noteList = jsonDecode(notesJson);
      notes = noteList.map((json) => Note.fromJson(json as Map<String, dynamic>)).toList();
    }
  }

  static Future<void> save() async {
    if (_prefs != null) {
      final String notesJson = jsonEncode(notes.map((note) => note.toJson()).toList());
      await _prefs!.setString('notes', notesJson);
    }
  }

  static void add(Note note) {
    notes.add(note);
    save();
  }

  static void edit(int index, Note note) {
    notes[index] = note;
    save();
  }

  static void delete(int index) {
    notes.removeAt(index);
    save();
  }
}
