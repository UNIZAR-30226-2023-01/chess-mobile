import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  final Color innerBoxColor;
  final String text;
  final Color textColor;
  final Function()? onTap;
  const NavigateButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.innerBoxColor,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: innerBoxColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 30, 35, 44),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
