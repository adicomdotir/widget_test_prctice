import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_03/data/model/user.dart';
import 'package:widget_test_practice/clean_architecture/sample_03/domain/use_case/sign_up_use_case.dart';

class SignUpScreen extends StatefulWidget {
  final SignUpUseCase signUpUseCase;

  const SignUpScreen({required this.signUpUseCase, Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      final user = User(id: '', email: _email, password: _password);
      widget.signUpUseCase.execute(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSignUpPressed,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
