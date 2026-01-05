import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/services/auth/auth_service.dart';
import 'package:news/core/services/toast/toast_service.dart';
import 'package:news/core/widgets/button/button_widget.dart';
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

  void login() async {
    if (formKey.currentState!.validate()) {
      var email = emailController.text;
      var password = passwordController.text;
      var result = await AuthService.login(email, password);
      if (result) {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Login successful', Colors.green, 2);
        // ignore: use_build_context_synchronously
        context.go('/');
        return;
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Incorrect email or password', Colors.red, 2);
    }
  }

  void goToRegister() {
    context.push('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Column(
          spacing: 10,
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
                  ButtonWidget(click: login, text: 'Login'),
                ],
              ),
            ),
            Row(
              children: [
                Text('Create acount ', style: TextStyle(fontSize: 20)),
                InkWell(
                  onTap: () => goToRegister(),
                  child: Text(
                    'here',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
