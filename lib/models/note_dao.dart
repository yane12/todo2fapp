
import 'package:cloud_firestore/cloud_firestore.dart';
import './note.dart';
import 'auth_dao.dart';

class NoteDao {
  NoteDao(this.authDao);
  final AuthDao authDao;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('notes');

  void addNote(String noteTitle, String noteContent) {
    final note = Note(
      date: DateTime.now(),
      email: authDao.email()!,
      noteTitle: noteTitle,
      noteContent: noteContent,
    );
    collection.add(note.toJson()); // 1
  }

  void updateNote(String docId, String noteTitle, String noteContent) {
    final note = Note(
      date: DateTime.now(),
      email: authDao.email()!,
      noteTitle: noteTitle,
      noteContent: noteContent,
    );
    collection.doc(docId).update(note.toJson()); // 1
  }



  Stream<List<Note>> getNoteStream() {
    return collection
        .where('email', isEqualTo:  authDao.email()!)
        .snapshots()
        .map((snapshot) {
      return [...snapshot.docs.map(Note.fromSnapshot)];
    });
  }
}
