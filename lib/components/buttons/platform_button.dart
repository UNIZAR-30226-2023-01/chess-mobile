import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  final String logoPath;
  const PlatformButton({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromARGB(255, 208, 211, 218),
        ),
      ),
      child: Image.asset(
        logoPath,
        height: 40,
      ),
    );
  }
}
