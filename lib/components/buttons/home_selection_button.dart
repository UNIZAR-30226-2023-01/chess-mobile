import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../visual/screen_size.dart';

class SelectionMenu<T> {
  List<String> listOfVisualValues = List.empty(growable: true);
  List<T> listOfCorrectValues = List.empty(growable: true);
  List<String> listOf = List.empty(growable: true);
  String selectedVisualValue;
  late T selectedCorrectValue;

  SelectionMenu(this.listOfVisualValues, this.listOfCorrectValues,
      this.selectedVisualValue) {
    for (int i = 0; i < listOfVisualValues.length; i++) {
      if (listOfVisualValues[i] == selectedVisualValue) {
        selectedCorrectValue = listOfCorrectValues[i];
        break;
      }
    }
  }

  Container selectionMenu(BuildContext context) {
    return Container(
      width: defaultWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.25,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            iconStyleData: const IconStyleData(iconSize: 0),
            value: selectedVisualValue,
            isExpanded: true,
            items: listOfVisualValues.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Center(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 19,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() {
              selectedVisualValue = value ?? "";
              for (int i = 0; i < listOfVisualValues.length; i++) {
                if (listOfVisualValues[i] == selectedVisualValue) {
                  selectedCorrectValue = listOfCorrectValues[i];
                  break;
                }
              }
            }),
          ),
        );
      }),
    );
  }

  static Row rowOption(BuildContext context, String text, Widget widget) {
    return Row(children: [
      SizedBox(
        width: defaultWidth * 0.25,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      SizedBox(width: defaultWidth * 0.05),
      widget,
    ]);
  }
}
