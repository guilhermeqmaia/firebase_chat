import 'dart:io';

import 'package:fire_base_chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

import 'package:fire_base_chat/core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);
  final void Function(AuthFormData data) onSubmit;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();
  bool isPasswordObscure = true;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formkey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_authFormData.image == null && _authFormData.isSignup) {
      return _showError("Imagem não selecionada");
    }
    widget.onSubmit(_authFormData);
  }

  void _handleImagePick(File image) {
    _authFormData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              if (_authFormData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_authFormData.isSignup)
                TextFormField(
                  key: const Key('name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name = name,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                  validator: (value) {
                    final name = value ?? '';
                    if (name.trim().length < 5) {
                      return "Nome deve ter no mínimo 5 caracteres";
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const Key('email'),
                initialValue: _authFormData.email,
                onChanged: (email) => _authFormData.email = email,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                validator: (value) {
                  final email = value ?? '';
                  if (!email.contains("@")) {
                    return "E-mail inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const Key('password'),
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password = password,
                decoration: InputDecoration(
                  label: const Text('Senha'),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      isPasswordObscure = !isPasswordObscure;
                    }),
                    icon: Icon(
                      isPasswordObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                obscureText: isPasswordObscure,
                validator: (value) {
                  final password = value ?? '';
                  if (password.length < 6) {
                    return "Senha deve ter no mínimo 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authFormData.isLogin ? 'Entrar' : 'Cadastar',
                ),
              ),
              TextButton(
                child: Text(
                  _authFormData.isLogin
                      ? 'Criar uma nova conta?'
                      : "Já possui conta?",
                ),
                onPressed: () => setState(() => _authFormData.toggleAuthMode()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
