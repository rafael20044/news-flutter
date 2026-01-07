import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String name;
  final Function(String category) onSelectCategory;
  const MenuWidget({
    super.key,
    required this.name,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.only(top: 20),
            child: Column(
              children: [Icon(Icons.person), Text('Welcome $name 😊')],
            ),
          ),
          ListTile(
            title: Text('General'),
            onTap: () {
              onSelectCategory('general');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sport'),
            onTap: () {
              onSelectCategory('sport');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Technology'),
            onTap: () {
              onSelectCategory('technology');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Science'),
            onTap: () {
              onSelectCategory('science');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Health'),
            onTap: () {
              onSelectCategory('health');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Entertainment'),
            onTap: () {
              onSelectCategory('entertainment');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
