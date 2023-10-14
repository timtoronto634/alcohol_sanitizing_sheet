import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _onPressed,
        child: Text('要約する'),
      ),
    );
  }
}
