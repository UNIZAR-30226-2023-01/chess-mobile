import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../visual/set_image_color.dart';

SizedBox shortButton(BuildContext context, bool type, String image, String text,
    Function() action) {
  return SizedBox(
    width: defaultWidth * 0.3875,
    child: Material(
      color: type
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: action,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: defaultHeight * 0.01,
              horizontal: defaultWidth * 0.075,
            ),
            child: SizedBox(
              height: defaultWidth * 0.15,
              child: SizedBox(
                height: defaultWidth * 0.15,
                child: setImageColor(
                    context,
                    image,
                    type
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: defaultWidth * 0.07),
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
        ]),
      ),
    ),
  );
}
