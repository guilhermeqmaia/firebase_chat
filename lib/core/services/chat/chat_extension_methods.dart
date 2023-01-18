import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';

class ChatExtensionMethods {
  static ChatMessage fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc,
          SnapshotOptions? options) =>
      ChatMessage.fromMap(doc.data()!);

  static Map<String, dynamic> toFirestore(
          ChatMessage msg, SetOptions? options) =>
      msg.toMap();

  static Stream<QuerySnapshot<ChatMessage>> getChatSnapshot() {
    final store = FirebaseFirestore.instance;
    return store
        .collection('chat')
        .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static List<ChatMessage> getChatList(QuerySnapshot<ChatMessage> query) {
    List<ChatMessage> list = query.docs.map((element) {
      return element.data();
    }).toList();
    return list;
  }
}
