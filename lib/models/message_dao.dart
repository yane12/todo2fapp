import 'package:cloud_firestore/cloud_firestore.dart';

import './message.dart';
import 'auth_dao.dart';

class MessageDao {
  MessageDao(this.authDao);

  final AuthDao authDao;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('messages');



  void saveMessage(String text, String reciver) {
    final message = Message(
      date: DateTime.now(),
      email: authDao.email()!,
      reciver: reciver,
      text: text,
    );

    List<String> emails = [authDao.email()!, reciver];
    emails.sort();
    String chatRoomId = emails.join('_');

    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toJson());
  }



  Stream<List<Message>> getMessageStream(String reciver) {
    List<String> emails = [authDao.email()!, reciver];
    emails.sort();
    String chatRoomId = emails.join('_');

    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return [...snapshot.docs.map(Message.fromSnapshot)];
    });
  }
}
