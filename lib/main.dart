import 'package:flutter/material.dart';
import 'services/note_service.dart';
import 'widgets/note_tile.dart';
import 'pages/add_note_page.dart';
import 'pages/edit_note_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    NoteService.init();
  }

  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNotePage()),
    ).then((note) {
      if (note != null) {
        NoteService.add(note);
        setState(() {});
      }
    });
  }

  void _deleteNote(int index) {
    NoteService.delete(index);
    setState(() {});
  }

  void _editNote(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(
          note: NoteService.notes[index],
          index: index,
        ),
      ),
    ).then((updatedNote) {
      if (updatedNote != null) {
        NoteService.edit(index, updatedNote);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: NoteService.notes.isEmpty
              ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text('No notes yet. Tap + to add one!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.orange[700],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: NoteService.notes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  note: NoteService.notes[index],
                  onEdit: () => _editNote(index),
                  onDelete: () => _deleteNote(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
