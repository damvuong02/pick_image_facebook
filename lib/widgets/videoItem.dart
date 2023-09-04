import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoItem extends StatefulWidget {
  final String path;
  final bool isMultipleSelect;
  final bool isSelected;
  final int? index;
  final VoidCallback onTap;
  const MyVideoItem({
    super.key,
    required this.path,
    required this.isMultipleSelect,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  State<MyVideoItem> createState() => _MyVideoItemState();
}

class _MyVideoItemState extends State<MyVideoItem> {
  late VideoPlayerController _controller;
  int minute = 0;
  int second = 0;
  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.file(File(widget.path));
    await _controller.initialize();
    setState(() {
      minute = _controller.value.duration.inMinutes;
      second = _controller.value.duration.inSeconds % 60;
    });
  }

  @override
  void initState() {
    super.initState();

    _initializeVideoPlayer();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMultipleSelect) {
      return InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Column(
              children: [
                _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 4 / 3.3,
                        child: VideoPlayer(_controller),
                      )
                    : const CircularProgressIndicator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.video_camera_back_outlined),
                    Text('$minute:$second'),
                  ],
                )
              ],
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
      return Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: 4 / 3.3,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.video_camera_back_outlined),
              Text('$minute:$second'),
            ],
          )
        ],
      );
    }
  }
}
