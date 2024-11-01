import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/message.dart';
import 'message_widget.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({super.key, required this.reciver});

  final String reciver;
  @override
  ConsumerState createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveMessage() {
    if (_messageController.text.isNotEmpty) {
      final messageDao = ref.read(messageDaoProvider);
      messageDao.saveMessage(_messageController.text.trim(), widget.reciver);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('note app'),
        elevation: 4.0,
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final data = ref.watch(messageListProvider(widget.reciver));
                return data.when(
                  loading: () => const Center(
                    child: LinearProgressIndicator(),
                  ),
                  data: (List<Message> messages) => ListView(
                    controller: _scrollController,
                    reverse: true,
                    children: [
                      for (final message in messages) //
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 4.0),
                          child: MessageWidget(message),
                        ),
                    ],
                  ),
                  error: (error, stackTrace) {
                    return Center(child: Text('$error'));
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _messageController,
                      autocorrect: true,
                      enableSuggestions: true,
                      onSubmitted: (_) => _saveMessage(),
                      decoration:
                          const InputDecoration(hintText: 'Enter new message'),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _messageController,
                  builder: (BuildContext context, TextEditingValue value,
                      Widget? child) {
                    return IconButton(
                      onPressed:
                          value.text.trim().isNotEmpty ? _saveMessage : null,
                      icon: const Icon(Icons.send),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
