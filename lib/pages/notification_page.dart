import 'package:fire_base_chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNoficationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        actions: [
          IconButton(
            onPressed: () {
              service.clearNotifications();
            },
            icon: const Icon(Icons.clear_all_rounded),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].body),
            onTap: () => service.remove(index),
          );
        },
      ),
    );
  }
}
