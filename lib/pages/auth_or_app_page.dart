// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:fire_base_chat/core/services/auth/auth_service.dart';
import 'package:fire_base_chat/pages/auth_page.dart';
import 'package:fire_base_chat/pages/chat_page.dart';
import 'package:fire_base_chat/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/models/chat_user.dart';
import 'package:firebase_core/firebase_core.dart';

import '../core/services/notification/chat_notification_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  Future<void> initFirebase(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<ChatNoficationService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFirebase(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }
        return StreamBuilder<ChatUser?>(
          stream: AuthService().userChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            } else {
              return snapshot.hasData ? const ChatPage() : const AuthPage();
            }
          },
        );
      },
    );
  }
}
