
import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  Contact({
    required this.date,
    required this.email,

    this.reference,
  });

  final DateTime date;
  final String email;


  DocumentReference? reference;

  factory Contact.fromJson(Map<dynamic, dynamic> json) => Contact(
        date: (json['date'] as Timestamp).toDate(),
        email: json['email'] as String,
        
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date,
        'email': email,
        
      };

  factory Contact.fromSnapshot(DocumentSnapshot snapshot) {
    final contact = Contact.fromJson(
      snapshot.data() as Map<String, dynamic>,
    );
    contact.reference = snapshot.reference;
    return contact;
  }
}
