import 'package:flutter/material.dart';

import '../../../widgets/custom_textfield.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker(
      {super.key, required this.colorsController, required this.colors});

  final TextEditingController colorsController;
  final List<String> colors;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: widget.colorsController,
                    hintText: 'Colors',
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.colors.add(widget.colorsController.text);
                      });
                    },
                    icon: const Icon(Icons.add))
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        widget.colors.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: 40,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.colors.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color:
                              Color(int.parse('0xff${widget.colors[index]}')),
                          borderRadius: BorderRadius.circular(100)),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
