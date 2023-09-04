import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final XFile videoFile;

  const VideoScreen({required this.videoFile});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoController;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    _isPlaying = false;
    final videoFile = File(widget.videoFile.path);
    _videoController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _togglePlayPause,
          child: AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_videoController),
                if (!_isPlaying)
                  Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
