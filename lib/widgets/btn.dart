import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final String btnText;
  final Color textColor;
  final Color bgColor;

  const Btn(
      {super.key,
      required this.btnText,
      required this.textColor,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 22,
        ),
        child: Text(
          btnText,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
