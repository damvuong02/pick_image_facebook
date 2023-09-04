import 'package:flutter/material.dart';
import 'package:load_multiple_image/widgets/imageItem.dart';

class MyDisplayImage extends StatefulWidget {
  final List<String> images;
  final bool isMultipleselect;
  const MyDisplayImage({
    super.key,
    required this.images,
    required this.isMultipleselect,
  });

  @override
  State<MyDisplayImage> createState() => _MyDisplayImageState();
}

class _MyDisplayImageState extends State<MyDisplayImage> {
  List<String> selectedPaths = [];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust the number of columns as needed
      ),
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        final isSelected = selectedPaths.contains(widget.images[index]);
        final selectedIndex =
            isSelected ? selectedPaths.indexOf(widget.images[index]) + 1 : null;
        return MyImageItem(
          path: widget.images[index],
          isMultipleSelect: widget.isMultipleselect,
          isSelected: selectedPaths.contains(widget.images[index]),
          index: selectedIndex,
          onTap: () {
            setState(() {
              if (widget.isMultipleselect) {
                if (isSelected) {
                  selectedPaths.remove(widget.images[index]);
                } else {
                  selectedPaths.add(widget.images[index]);
                }
              } else {}
            });
          },
        );
      },
    );
  }
}
