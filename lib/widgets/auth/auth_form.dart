import 'dart:io';

import 'package:flutter/material.dart';

import '../pickers/image_picker.dart';

class AuthForm extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AuthForm(this.submitUserForm, this.isloading);

  final void Function(
    String? userName,
    String? email,
    String? passsword,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) submitUserForm;
  final bool isloading;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  // ignore: prefer_final_fields
  String? _userName = '';
  String? _userPassword = '';
  String? _userEmail = '';
  bool _isLogin = true;
  File? forwadedImage;

  void _pickedImage(File? image) {
    forwadedImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (forwadedImage == null && !_isLogin) {
      print('we are here');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please, you have to pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      ));

      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitUserForm(
        _userName?.trim(),
        _userEmail?.trim(),
        _userPassword?.trim(),
        forwadedImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) ImagePickerHelper(_pickedImage),
                if (!_isLogin)
                  TextFormField(
                      key: const ValueKey('name'),
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.words,
                      decoration:
                          const InputDecoration(labelText: 'Enter your name'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Please enter at least 4 charachters for the name.';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _userName = newValue),
                TextFormField(
                  key: const ValueKey('Email'),
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  decoration:
                      const InputDecoration(labelText: 'Enter your E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid E-mail.';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _userEmail = newValue,
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  decoration:
                      const InputDecoration(labelText: 'Enter yot password'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 7) {
                      return 'Please enter a 7 charachter password at least.';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _userPassword = newValue,
                ),
                const SizedBox(height: 10),
                if (widget.isloading) const CircularProgressIndicator(),
                if (!widget.isloading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                if (!widget.isloading)
                  TextButton(
                    child: Text(
                        _isLogin ? 'Create new account' : 'I have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
