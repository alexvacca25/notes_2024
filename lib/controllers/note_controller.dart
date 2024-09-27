import 'package:get/get.dart';
import 'package:notes_2024/services/note_service.dart';
import '../models/note_model.dart';


class NoteController extends GetxController {
  final NoteService _noteService = NoteService();  
  RxList<Note> notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  
  void fetchNotes() async {
    notes.value = await _noteService.getNotes();
  }

  
  Future<void> addNote(Note note) async {
    await _noteService.addNote(note);
    fetchNotes();  
  }

  
  Future<void> updateNote(Note note) async {
    await _noteService.updateNote(note);
    fetchNotes();  
  }

  
  Future<void> deleteNote(String noteId) async {
    await _noteService.deleteNote(noteId);
    fetchNotes();  
  }
}

