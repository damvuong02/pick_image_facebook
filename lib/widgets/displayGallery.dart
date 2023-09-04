import 'package:flutter/material.dart';
import 'package:load_multiple_image/widgets/imageItem.dart';
import 'package:load_multiple_image/widgets/videoItem.dart';

class MyDisplayGallery extends StatefulWidget {
  final List<String> images;
  final List<String> videos;
  final bool isMultipleselect;
  const MyDisplayGallery({
    super.key,
    required this.images,
    required this.videos,
    required this.isMultipleselect,
  });

  @override
  State<MyDisplayGallery> createState() => _MyDisplayGalleryState();
}

class _MyDisplayGalleryState extends State<MyDisplayGallery> {
  List<String> selectedPaths = [];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust the number of columns as needed
      ),
      itemCount: widget.images.length + widget.videos.length,
      itemBuilder: (context, index) {
        if (index < widget.videos.length) {
          // Display video item
          int videoIndex = index;
          bool isSelected = selectedPaths.contains(widget.videos[videoIndex]);
          return MyVideoItem(
            path: widget.videos[index],
            isMultipleSelect: widget.isMultipleselect,
            isSelected: isSelected,
            index: isSelected
                ? selectedPaths.indexOf(widget.videos[videoIndex]) + 1
                : null,
            onTap: () {
              setState(() {
                if (widget.isMultipleselect) {
                  if (isSelected) {
                    selectedPaths.remove(widget.videos[index]);
                  } else {
                    selectedPaths.add(widget.videos[index]);
                  }
                } else {
                  // Handle single selection logic here
                }
              });
            },
          );
        } else {
          // Display image item
          int imageIndex = index - widget.videos.length;
          bool isSelected = selectedPaths.contains(widget.images[imageIndex]);
          return MyImageItem(
            path: widget.images[imageIndex],
            isMultipleSelect: widget.isMultipleselect,
            isSelected: isSelected,
            index: isSelected
                ? selectedPaths.indexOf(widget.images[imageIndex]) + 1
                : null,
            onTap: () {
              setState(() {
                if (widget.isMultipleselect) {
                  if (isSelected) {
                    selectedPaths.remove(widget.images[imageIndex]);
                  } else {
                    selectedPaths.add(widget.images[imageIndex]);
                  }
                } else {}
              });
            },
          );
        }
      },
    );
  }
}
