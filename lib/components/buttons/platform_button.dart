import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  final String logoPath;
  final String message;
  final Future<void> Function() onTap;
  const PlatformButton(
      {super.key,
      required this.logoPath,
      required this.message,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        color: Colors.grey[50],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(
            color: Color.fromARGB(255, 208, 211, 218),
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Image.asset(
                  logoPath,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  message,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
