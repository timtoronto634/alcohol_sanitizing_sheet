import 'package:flutter/material.dart';

class DoSummaryButton extends StatelessWidget {
  final VoidCallback onPressed;

  DoSummaryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(219, 171, 188, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
      ),
      child: const Text(
        '僕の強みを聞いてみる',
        style: TextStyle(
          color: Color.fromRGBO(50, 50, 50, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
