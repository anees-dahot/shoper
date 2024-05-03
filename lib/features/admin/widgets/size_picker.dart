import 'package:flutter/material.dart';

import '../../../widgets/custom_textfield.dart';

class SizePicker extends StatefulWidget {
  const SizePicker(
      {super.key, required this.sizesController, required this.sizes});

  final TextEditingController sizesController;
  final List<int> sizes;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
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
                    controller: widget.sizesController,
                    hintText: 'Size',
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.sizes
                            .add(int.parse(widget.sizesController.text));
                        widget.sizesController.clear();
                      });
                    },
                    icon: const Icon(Icons.add))
              ],
            )),
        // const SizedBox(
        //   height: 20,
        // ),
        widget.sizes.isEmpty
            ? const SizedBox()
            : Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.sizes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (widget.sizes.isNotEmpty) {
                          widget.sizes.remove(widget.sizes[index]);
                        }
                        setState(() {
                        
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(widget.sizes[index].toString()),
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
