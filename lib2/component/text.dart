import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final String title;
  const Test({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(color: Colors.black38, width: 1),
          shape: BoxShape.circle),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
