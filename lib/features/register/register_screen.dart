import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/widgets/form_user/form_user_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {

  void back() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: back, icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/newspaper.png',
                  height: 150,
                  width: 150,
                ),
                FormUserWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
