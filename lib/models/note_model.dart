import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  
  factory Note.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId,
      title: data['title'],
      content: data['content'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
    };
  }

  
  int daysSinceCreation() {
    final currentDate = DateTime.now();
    return currentDate.difference(date).inDays;
  }
}
