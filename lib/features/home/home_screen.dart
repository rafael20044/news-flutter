import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key });

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hola'),
    );
  }
}