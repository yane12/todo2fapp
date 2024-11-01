
import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact.dart';
import 'auth_dao.dart';

class ContactDao { 
  ContactDao(this.authDao);

  final AuthDao authDao;


  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  void addUser(String text) {
  
    final contact = Contact(
      date: DateTime.now(),
      email: authDao.email()!,
      
    );
    collection.add(contact.toJson()); // 1
  }

  Stream<List<Contact>> getContactStream() {
    return collection
        .where('email', isNotEqualTo: authDao.email())
        .snapshots()
        .map((snapshot) {
      return [...snapshot.docs.map(Contact.fromSnapshot)];
    });
  }
}
