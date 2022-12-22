import 'package:flutter/material.dart';

class DigitScroll extends StatelessWidget {
  final int data;

  const DigitScroll({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          (data).toString(),
          style: const TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}