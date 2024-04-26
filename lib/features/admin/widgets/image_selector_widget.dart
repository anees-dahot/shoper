import 'package:flutter/cupertino.dart';

class ImageSelectorWidget extends StatelessWidget {
  const ImageSelectorWidget({
    super.key,
    required this.width,
    required this.height, required this.onTap,
  });

  final double width;
  final double height;
  final VoidCallback onTap;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.95,
        height: height * 0.25,
       decoration: BoxDecoration(
        color: const Color.fromARGB(255, 246, 244, 244),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 187, 187, 187)
        )
       ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.folder_open,
              size: 58,
            ),
            Text('Select Product Images'),
            Text('(Long press image to select multiple)', style: TextStyle(fontSize: 10),)
          ],
        ),
      ),
    );
  }
}