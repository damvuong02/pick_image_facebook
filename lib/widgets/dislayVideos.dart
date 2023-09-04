import 'package:flutter/material.dart';
import 'package:load_multiple_image/widgets/videoItem.dart';

class MyDisplayVideo extends StatefulWidget {
  final List<String> videos;
  final bool isMultipleselect;
  const MyDisplayVideo({
    super.key,
    required this.videos,
    required this.isMultipleselect,
  });

  @override
  State<MyDisplayVideo> createState() => _MyDisplayVideoState();
}

class _MyDisplayVideoState extends State<MyDisplayVideo> {
  List<String> selectedPaths = [];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust the number of columns as needed
      ),
      itemCount: widget.videos.length,
      itemBuilder: (context, index) {
        final isSelected = selectedPaths.contains(widget.videos[index]);
        final selectedIndex =
            isSelected ? selectedPaths.indexOf(widget.videos[index]) + 1 : null;
        return MyVideoItem(
          path: widget.videos[index],
          isMultipleSelect: widget.isMultipleselect,
          isSelected: selectedPaths.contains(widget.videos[index]),
          index: selectedIndex,
          onTap: () {
            setState(() {
              if (widget.isMultipleselect) {
                if (isSelected) {
                  selectedPaths.remove(widget.videos[index]);
                } else {
                  selectedPaths.add(widget.videos[index]);
                }
              } else {}
            });
          },
        );
      },
    );
  }
}
