import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_2024/controllers/note_controller.dart';
import 'package:notes_2024/models/note_model.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';

class NoteDialog extends StatelessWidget {
  final Note? note;
  final bool isEdit;
  final NoteController noteController = Get.find();

  NoteDialog({super.key, this.note, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note?.title ?? '');
    TextEditingController contentController =
        TextEditingController(text: note?.content ?? '');

    return AlertDialog(
      title: Text(isEdit ? 'Editar Nota' : 'Agregar Nota'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hintText: 'Título',
            controller: titleController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Contenido',
            controller: contentController,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text(isEdit ? 'Actualizar' : 'Guardar'),
          onPressed: () {
            if (isEdit) {
              noteController.updateNote(
                Note(
                  id: note!.id,
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now(),
                ),
              );
            } else {
              noteController.addNote(
                Note(
                  id: '',
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now(),
                ),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
