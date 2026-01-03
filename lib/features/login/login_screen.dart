import 'package:flutter/material.dart';
import 'package:news/core/widgets/input/input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void disponse() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 160, left: 20, right: 20),
        child: Column(
          children: [
            Image.asset('assets/images/newspaper.png', height: 150, width: 150),
            Form(
              key: formKey,
              child: Column(
                spacing: 10,
                children: [
                  InputWidget(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    hitText: 'example@gmail.com',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email';
                        
                      }
                      return null;
                    },
                  ),
                  InputWidget(
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Password',
                    hitText: '*************',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () => login(),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
