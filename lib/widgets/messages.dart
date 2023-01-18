import 'package:fire_base_chat/core/models/chat_message.dart';
import 'package:fire_base_chat/core/services/auth/auth_service.dart';
import 'package:fire_base_chat/core/services/chat/chat_service.dart';
import 'package:fire_base_chat/widgets/message_bubble.dart';
import 'package:flutter/cupertino.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sem dados. Vamos conversar?'),
          );
        } else {
          final msgs = snapshot.data!;
          final currentUser = AuthService().currentUser;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (context, index) {
              return MessageBubble(
                key: Key(msgs[index].id),
                message: msgs[index],
                belongsToCurrentUser: currentUser?.id == msgs[index].userId,
              );
            },
          );
        }
      },
    );
  }
}
