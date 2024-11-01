
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  Note({
    required this.date,
    required this.email,
    required this.noteTitle,
    required this.noteContent,
    this.reference,
  });

  final DateTime date;
  final String email;
  final String noteTitle;
  final String noteContent;

  DocumentReference? reference;

  factory Note.fromJson(Map<dynamic, dynamic> json) => Note(
        date: (json['date'] as Timestamp).toDate(),
        email: json['email'] as String,
        noteTitle: json['noteTitle'] as String,
        noteContent: json['noteContent'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date,
        'email': email,
        'noteTitle': noteTitle,
        'noteContent': noteContent,
      };

  factory Note.fromSnapshot(DocumentSnapshot snapshot) {
    final note = Note.fromJson(
      snapshot.data() as Map<String, dynamic>,
    );
    note.reference = snapshot.reference;
    return note;
  }
}
