import 'package:flutter/material.dart';
import 'package:todoapp/components/contacts_list.dart';
import 'package:todoapp/components/note_list.dart';
// import 'package:todoapp/screens/note_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tab,
        children: const [
          NoteList(),
          ContactList(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.credit_card),
            label: 'Note',
            selectedIcon: Icon(Icons.note),
          ),
          NavigationDestination(
            icon: Icon(Icons.question_answer),
            label: 'Chat',
            selectedIcon: Icon(Icons.chat),
          ),
        ],
      ),
    );
  }
}
