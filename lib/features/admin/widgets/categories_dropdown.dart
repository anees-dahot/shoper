import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final double width;
  final double height;
  

  const MyDropdown({
    Key? key,
    required this.items,
    this.initialValue, required this.width, required this.height,
   
  }) : super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 246, 244, 244),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 187, 187, 187))),
      child: DropdownButton<String>(
      value: _selectedValue,
      isExpanded: true, // Makes the dropdown fill the available space
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newSelectedValue) {
        setState(() {
          _selectedValue = newSelectedValue;
        });
     
      },
    )
    );
    
    
  }
}
