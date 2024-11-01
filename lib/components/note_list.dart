import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/components/add_note.dart';
import 'package:todoapp/components/edit_note.dart';
import 'package:todoapp/models/note.dart';
import 'package:todoapp/screens/note_card.dart';
import '../providers.dart';

class NoteList extends ConsumerStatefulWidget {
  const NoteList({
    super.key,
  });

  @override
  ConsumerState createState() => _NoteListState();
}

class _NoteListState extends ConsumerState<NoteList> {
  final ScrollController _scrollController = ScrollController();

  bool isGridView = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authDao = ref.watch(authDaoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('note app'),
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.grid_view : Icons.view_list),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          IconButton(
            onPressed: () {
              authDao.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final data = ref.watch(noteListProvider);
                return data.when(
                  loading: () => const Center(
                    child: LinearProgressIndicator(),
                  ),
                  data: (List<Note> notes) => isGridView
                      ? GridView.builder(
                         
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            String noteId = notes[index].reference!.id;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditNote(
                                                noteId: noteId,
                                                noteTitle: notes[index].noteTitle,
                                                noteContent:
                                                    notes[index].noteContent,
                                              )));
                                },
                                child: NoteCard(
                                    noteTitle: notes[index].noteTitle,
                                    noteContent: notes[index].noteContent,
                                  ),
                                ),
                              
                            );
                          },
                          controller: _scrollController,
                        )
                      : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            String noteId = notes[index].reference!.id;
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditNote(
                                                noteId: noteId,
                                                noteTitle: notes[index].noteTitle,
                                                noteContent:
                                                    notes[index].noteContent,
                                              )));
                                },
                                child: NoteCard(
                                  noteTitle: notes[index].noteTitle,
                                  noteContent: notes[index].noteContent,
                                ),
                              ),
                            );
                          },
                          controller: _scrollController,
                        ),
                  error: (error, stackTrace) {
                    return Center(child: Text('$error'));
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
