import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final IconData iconText;
  final String? Function(String?)? validator;
  const TextFieldCustom({
    super.key,
    required this.labelText,
    required this.obscureText,
    required this.iconText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 232, 236, 244),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              // Color.fromARGB(255, 59, 203, 255),
            ),
          ),
          fillColor: const Color.fromARGB(255, 247, 248, 249),
          filled: true,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 110, 113, 116),
          ),
          prefixIcon: Icon(iconText),
        ),
        validator: validator,
      ),
    );
  }
}
