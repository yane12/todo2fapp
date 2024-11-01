import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({
    super.key,
  });

  @override
  ConsumerState createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _addNote() {
    if (_titleController.text.isNotEmpty) {
      final noteDao = ref.read(noteDaoProvider);
      noteDao.addNote(_titleController.text.trim(), _contentController.text.trim());
      _titleController.clear();
      _contentController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, t) async {
        if (didPop) {
          _addNote();
          return;
        }
        
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Note'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: () async {
                //      _addNote();
                //   },
                //   child: const Text(
                //     'create',
                //     style: TextStyle(
                //       fontSize: 16,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
