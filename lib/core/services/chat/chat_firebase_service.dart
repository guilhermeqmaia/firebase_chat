import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_chat/core/services/chat/chat_service.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'chat_extension_methods.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final snapshots = ChatExtensionMethods.getChatSnapshot();

    return snapshots.map((event) {
      return ChatExtensionMethods.getChatList(event);
    });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage.fromSave(text, user);
    final docRef = await store
        .collection('chat')
        .withConverter(
            fromFirestore: ChatExtensionMethods.fromFirestore,
            toFirestore: ChatExtensionMethods.toFirestore)
        .add(msg);
    final snapshot = await docRef.get();

    return snapshot.data();
  }
}
