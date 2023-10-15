import 'package:flutter/material.dart';

class ReplyMessageBox extends StatelessWidget {
  final String message;
  final bool isLoading;

  const ReplyMessageBox({required this.message, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return (Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF3662E3), //色
              width: 4, //太さ
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white.withOpacity(0.9)),
        child: SizedBox(
          width: double.infinity,
          height: 300 - MediaQuery.of(context).viewInsets.bottom,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                isLoading ? const CircularProgressIndicator() : Text(message),
          ),
        )));
  }
}
