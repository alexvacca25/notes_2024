import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';
import 'package:notes_2024/screens/widget/note_dialog.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNoteDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: 'Buscar...',
              controller: searchController,
              isSearch: true,
              icon: Icons.search,
              onChanged: (value) {
                noteController.notes.value = noteController.notes.where((note) {
                  return note.title
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      note.content.toLowerCase().contains(value.toLowerCase());
                }).toList();
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (noteController.notes.isEmpty) {
                return const Center(child: Text('No hay notas'));
              }
              return ListView.builder(
                itemCount: noteController.notes.length,
                itemBuilder: (context, index) {
                  final note = noteController.notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note.content),
                        Text(
                          'Creada hace ${note.daysSinceCreation()} días',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => noteController.deleteNote(note.id),
                    ),
                    onTap: () =>
                        _showNoteDialog(context, note: note, isEdit: true),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showNoteDialog(BuildContext context,
      {Note? note, bool isEdit = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return NoteDialog(note: note, isEdit: isEdit);
      },
    );
  }
}
