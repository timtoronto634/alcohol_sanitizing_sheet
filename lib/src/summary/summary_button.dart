import 'package:flutter/material.dart';

class DoSummaryButton extends StatelessWidget {
  final VoidCallback onPressed;

  DoSummaryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(219, 171, 188, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
        foregroundColor: const Color.fromRGBO(50, 50, 50, 1),
      ),
      icon: const Icon(Icons.star),
      label: const Text(
        '「ぼく」の魅力を教えて！',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
