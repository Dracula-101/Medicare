import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? icon;
  const CustomBackButton({super.key, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon ?? const Icon(Icons.arrow_back_ios),
    );
  }
}
