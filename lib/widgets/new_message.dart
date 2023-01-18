import 'package:fire_base_chat/core/services/auth/auth_service.dart';
import 'package:fire_base_chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _controller = TextEditingController();
  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;
    if (user != null) {
      ChatService().save(_message, user);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) => setState(() => _message = value),
      onSubmitted: (_) => _message.trim().isEmpty ? null : _sendMessage,
      decoration: InputDecoration(
        labelText: 'Enviar mensagem...',
        suffixIcon: IconButton(
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
