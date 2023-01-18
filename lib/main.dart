import 'package:fire_base_chat/core/services/notification/chat_notification_service.dart';
import 'package:fire_base_chat/pages/auth_or_app_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatNoficationService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthOrAppPage(),
      ),
    );
  }
}
