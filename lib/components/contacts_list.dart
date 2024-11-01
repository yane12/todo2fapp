import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/components/message_list.dart';
import 'package:todoapp/models/contact.dart';

import '../providers.dart';

class ContactList extends ConsumerStatefulWidget {
  const ContactList({
    super.key,
  });

  @override
  ConsumerState createState() => _ContactListState();
}

class _ContactListState extends ConsumerState<ContactList> {
  final ScrollController _scrollController = ScrollController();

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
                final data = ref.watch(contactListProvider);
                return data.when(
                  loading: () => const Center(
                    child: LinearProgressIndicator(),
                  ),
                  data: (List<Contact> contacts) => ListView.builder(
                    itemCount: contacts.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      String reciver = contacts[index].email;
                      return InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MessageList(
                                        reciver: reciver,
                                      )));
                        },
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(contacts[index].email),
                          
                        ),
                      );
                    },
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
    );
  }
}
