import 'package:flutter/material.dart';
import 'package:news/core/model/user.dart';
import 'package:news/core/services/auth/auth_service.dart';
import 'package:news/core/widgets/menu/menu_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;
  String selectedCategory = 'general';

  void _loadData() async {
    final result = await AuthService.getUser();
    setState(() {
      user = result;
    });
  }

  void changeCategory(String category) {
    if (category == selectedCategory) {
      return;
    }
    setState(() {
      selectedCategory = category;
    });
  }

  void goToProfile() {}

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: goToProfile,
            icon: Icon(Icons.account_circle_rounded, size: 40),
          ),
        ],
      ),
      drawer: MenuWidget(
        name: user.name,
        onSelectCategory: (category) => changeCategory(category),
      ),
    );
  }
}
