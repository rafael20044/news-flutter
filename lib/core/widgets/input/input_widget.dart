import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hitText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;

  const InputWidget({
    super.key, 
    required this.controller,
    required this.labelText,
    this.validator,
    this.hitText = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hitText,
        border: OutlineInputBorder(),
        ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
