import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  final Function()? onTap;
  const ReturnButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color.fromARGB(35, 30, 35, 44),
            width: 1,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Color.fromARGB(255, 30, 35, 44),
          ),
        ),
      ),
    );
  }
}
