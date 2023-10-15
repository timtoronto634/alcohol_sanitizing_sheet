import 'package:flutter/material.dart';

class ReplyMessageBox extends StatelessWidget {
  final String summary;
  final bool isLoading;

  const ReplyMessageBox({required this.summary, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return (Container(
      // width: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/box.png'),
          alignment: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 18, left: 32, right: 32),
      constraints: const BoxConstraints(),
      child: Container(
        height: 200,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: isLoading ? const CircularProgressIndicator() : Text(summary),
        ),
      ),
    ));
  }
}
