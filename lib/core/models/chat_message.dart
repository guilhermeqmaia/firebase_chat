import 'package:fire_base_chat/core/models/chat_user.dart';

class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userImageUrl;
  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userImageUrl: map['userImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'text': text});
    result.addAll({'createdAt': createdAt.toIso8601String()});
    result.addAll({'userId': userId});
    result.addAll({'userName': userName});
    result.addAll({'userImageUrl': userImageUrl});

    return result;
  }

  factory ChatMessage.fromSave(String text, ChatUser user) {
    return ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
  }
}
