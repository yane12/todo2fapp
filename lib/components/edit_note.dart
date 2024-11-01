import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class EditNote extends ConsumerStatefulWidget {
   EditNote({
    super.key,
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
  });

  final String noteId;
  final String noteTitle;
  final String noteContent;

  @override
  ConsumerState createState() => _EditNoteState();
}

class _EditNoteState extends ConsumerState<EditNote> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController.text = widget.noteTitle;
    _contentController.text = widget.noteContent;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _updateNote() {
    if (_titleController.text.isNotEmpty) {
      final noteDao = ref.read(noteDaoProvider);
      noteDao.updateNote(widget.noteId, _titleController.text.trim(), _contentController.text.trim());
      _titleController.clear();
      _contentController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, t) async {
        if (didPop) {
          _updateNote();
          return;
        }
        
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
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
                //      _updateNote();
                //   },
                //   child: const Text(
                //     'update',
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
