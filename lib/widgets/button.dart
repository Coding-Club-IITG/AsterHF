import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double width;
  final FontWeight fontweight;
  final double fontsize;
  final double height;

  const Button({
    super.key,
    required this.text,
    required this.width,
    required this.fontsize,
    required this.fontweight,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius:  BorderRadius.all(Radius.circular(10))),
      height: height,
      width: width,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: fontweight,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
