import 'package:fire_base_chat/core/models/chat_message.dart';
import 'package:fire_base_chat/core/models/chat_user.dart';
import 'package:fire_base_chat/core/services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Future<ChatMessage?> save(String text, ChatUser user);
  Stream<List<ChatMessage>> messagesStream();
  factory ChatService() {
    return ChatFirebaseService();
  }
}
