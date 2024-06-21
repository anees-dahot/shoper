import 'package:flutter/material.dart';


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
                    child: TextFormField(
                  controller: widget.colorsController,
                  decoration: const InputDecoration(
                    hintText: 'Colors',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(68, 0, 0, 0), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.colors.add(widget.colorsController.text);
                        widget.colorsController.clear();
                      });
                    },
                    icon: const Icon(Icons.add))
              ],
            )),
        // const SizedBox(
        //   height: 20,
        // ),
        widget.colors.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.colors.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (widget.colors.isNotEmpty) {
                          widget.colors.remove(widget.colors[index]);
                        }
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color:
                                Color(int.parse('0xff${widget.colors[index]}')),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    );
                  },
                ),
              ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
