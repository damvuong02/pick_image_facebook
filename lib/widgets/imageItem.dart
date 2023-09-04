import 'dart:io';

import 'package:flutter/material.dart';

class MyImageItem extends StatefulWidget {
  final String path;
  final bool isMultipleSelect;
  final bool isSelected;
  final int? index; //index trong mảng được chọn(mảng selectedPaths)
  final VoidCallback onTap;
  const MyImageItem({
    super.key,
    required this.path,
    required this.isMultipleSelect,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  State<MyImageItem> createState() => _MyImageItemState();
}

class _MyImageItemState extends State<MyImageItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.isMultipleSelect == true) {
      return InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(
                      File(widget.path),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            widget.isSelected
                ? Positioned(
                    top: 8,
                    left: 8,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Text(
                          widget.index.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(
                File(widget.path),
              ),
              fit: BoxFit.cover),
        ),
      );
    }
  }
}
