import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final int? fontSize;
  final void Function() click;

  const ButtonWidget({
    super.key, 
    required this.text, 
    required this.click,
    this.fontSize = 17
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 20, right: 20),
      ),
      child: Text(text, style: TextStyle(fontSize: 17)),
    );
  }
}
