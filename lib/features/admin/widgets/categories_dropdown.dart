import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final double width;
  final double height;
  final void Function(String?) onChanged;
  final String selectedValue;

  const MyDropdown({
    super.key,
    required this.items,
    required this.width,
    required this.height,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: widget.width,
        height: widget.height,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 246, 244, 244),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 187, 187, 187))),
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          underline: const SizedBox(),
          value: widget.selectedValue,
          isExpanded: true, // Makes the dropdown fill the available space
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ));
  }
}
