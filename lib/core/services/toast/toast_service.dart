import 'package:flutter/material.dart';

class ToastService {
  static void show(
    BuildContext context,
    String message,
    Color color,
    int duration,
  ) {
    ScaffoldMessenger.
      of(context).
      showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: Duration(seconds: duration),
        )
      );
  }
}
