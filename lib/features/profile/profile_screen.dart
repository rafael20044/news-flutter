import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/model/user.dart';
import 'package:news/core/services/auth/auth_service.dart';
import 'package:news/core/widgets/form_user/form_user_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;

  void back() {
    context.pop();
  }

  void getUser() async {
    final result = await AuthService.getUser();
    setState(() {
      user = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: back, icon: Icon(Icons.arrow_back)),
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(12),
        child: Column(
          children: [
            Icon(Icons.person, size: 100),
            FormUserWidget(isRegister: false, user: user),
          ],
        ),
      ),
    );
  }
}
