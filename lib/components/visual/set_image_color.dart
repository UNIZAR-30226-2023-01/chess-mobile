import 'package:flutter/material.dart';

ColorFiltered setImageColor(BuildContext context, String image, Color color) {
  return ColorFiltered(
    colorFilter: ColorFilter.mode(
      color,
      BlendMode.modulate,
    ),
    child: Image.asset('images/$image'),
  );
}
