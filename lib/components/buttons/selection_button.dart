import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../visual/screen_size.dart';

class SelectionMenu {
  List<String> listOfValues = List.empty(growable: true);
  String selectedValue;
  SelectionMenu(this.listOfValues, this.selectedValue);

  Container selectionMenu(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultWidth * 0.03),
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
            value: selectedValue,
            isExpanded: true,
            items: listOfValues.map((item) {
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
            onChanged: (value) => setState(() => selectedValue = value ?? ""),
          ),
        );
      }),
    );
  }
}
