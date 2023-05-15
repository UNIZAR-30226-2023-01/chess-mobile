import 'package:ajedrez/components/buttons/home/play.dart';
import 'package:flutter/material.dart';
import '../../components/visual/screen_size.dart';

// PopUp Errors coming from backend
Object popupERR(BuildContext context, String errorMsg) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      contentPadding: EdgeInsets.all(defaultWidth * 0.05),
      content: SizedBox(
        width: defaultWidth * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            const Icon(
              Icons.error_outline,
              color: Color.fromARGB(255, 224, 16, 16),
              size: 60,
            ),

            SizedBox(height: defaultWidth * 0.05),

            // Error text
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),

            SizedBox(height: defaultWidth * 0.05),

            // Exit pop up button
            playButton(context, "Ok", () => Navigator.pop(context))
          ],
        ),
      ),
    ),
  );
}
