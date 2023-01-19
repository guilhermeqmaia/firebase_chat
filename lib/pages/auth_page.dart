import 'package:fire_base_chat/core/models/auth_form_data.dart';
import 'package:fire_base_chat/widgets/auth_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  Future<void> _handleSubmit(AuthFormData data) async {
    try {
      setState(() => isLoading = true);
      if (data.isLogin) {
        await AuthService().login(data.email, data.password);
      } else {
        await AuthService().signup(
          data.name,
          data.email,
          data.password,
          data.image!,
        );
      }
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        isLoading = false;
        data.toggleAuthMode();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
