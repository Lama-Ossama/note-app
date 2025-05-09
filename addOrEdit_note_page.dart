import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../database/notes_database.dart';

class AddOrEditNotePage extends StatefulWidget {
  final Note? note; // if null, we're adding

  const AddOrEditNotePage({this.note});

  @override
  _AddOrEditNotePageState createState() => _AddOrEditNotePageState();
}

class _AddOrEditNotePageState extends State<AddOrEditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(isEditing ? 'Save Changes' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) return;

    if (isEditing) {
      final updatedNote = widget.note!.copy(title: title, content: content);
      await NotesDatabase.instance.update(updatedNote);
    } else {
      final newNote = Note(title: title, content: content);
      await NotesDatabase.instance.create(newNote);
    }

    Navigator.of(context).pop();
  }
}
