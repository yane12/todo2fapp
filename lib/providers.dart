
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/message.dart';

import 'models/message_dao.dart';
import 'models/auth_dao.dart';
import 'models/contact.dart';
import 'models/contact_dao.dart';
import 'models/note.dart';
import 'models/note_dao.dart';


final authDaoProvider = ChangeNotifierProvider<AuthDao>((ref) {
  return AuthDao();
});

final messageDaoProvider = Provider<MessageDao>((ref) {
  return MessageDao(ref.watch(authDaoProvider));
});

final messageListProvider = StreamProvider.family<List<Message>, String>((ref, reciver) {
  final messageDao = ref.watch(messageDaoProvider);
  return messageDao.getMessageStream(reciver);
});

final contactDaoProvider = Provider<ContactDao>((ref) {
  return ContactDao(ref.watch(authDaoProvider));
});

final contactListProvider = StreamProvider<List<Contact>>((ref) {
  final contactDao = ref.watch(contactDaoProvider);
  return contactDao.getContactStream();
});


final noteDaoProvider = Provider<NoteDao>((ref) {
  return NoteDao(ref.watch(authDaoProvider));
});

final noteListProvider = StreamProvider<List<Note>>((ref) {
  final noteDao = ref.watch(noteDaoProvider);
  return noteDao.getNoteStream();
});