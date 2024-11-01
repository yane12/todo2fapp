import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/message.dart';

class MessageWidget extends ConsumerWidget {
  const MessageWidget(
    this.message, {
    super.key,
  });

  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userDao = ref.watch(authDaoProvider);
    final myMessage = message.email == userDao.email();

    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: myMessage ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment:
            myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              
              !myMessage
                  ? Text(
                      message.email,
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                      ),
                    )
                  : const Text(''),
            
              Text(
                '',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
         
          Material(
            color: theme.colorScheme.surface,
            
            elevation: 1.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    message.text,
                    style: theme.textTheme.bodyLarge!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
