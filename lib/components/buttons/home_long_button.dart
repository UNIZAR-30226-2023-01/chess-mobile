import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../visual/set_image_color.dart';

SizedBox longButton(BuildContext context, bool type, String image, String text,
    Function() action) {
  return SizedBox(
    width: defaultWidth * 0.85,
    child: Material(
      color: type
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: action,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(defaultWidth * 0.025),
            child: SizedBox(
              height: defaultWidth * 0.175,
              child: setImageColor(
                  context,
                  image,
                  type
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultWidth * 0.03),
            child: SizedBox(
              width: defaultWidth * 0.45,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: type
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
