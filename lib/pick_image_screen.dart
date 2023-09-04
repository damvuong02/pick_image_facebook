import 'package:flutter/material.dart';
import 'package:load_multiple_image/widgets/dislayVideos.dart';
import 'package:load_multiple_image/widgets/displayGallery.dart';
import 'package:load_multiple_image/widgets/displayImages.dart';

import 'package:load_multiple_image/widgets/myDropdownButton.dart';
import 'package:load_multiple_image/widgets/myHorizontalListView.dart';

import 'functions/getAssets.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  List<String> images = [];
  List<String> videos = [];
  bool isMultipleSelect = false;

  String dropdownValue = 'Gallery'; // Initial dropdown value

  void updateSelectedValue(String? newValue) {
    setState(() {
      dropdownValue = newValue!; // Update selected value

      if (dropdownValue == 'Gallery') {
        GetAssets().getImagesPath(null).then((List<String> imageList) {
          setState(() {
            images = imageList;
          });
        });
        GetAssets().getVideosPath().then((List<String> videoList) {
          setState(() {
            videos = videoList;
          });
        });
      } else if (dropdownValue == 'Images') {
        GetAssets().getImagesPath(null).then((List<String> imageList) {
          setState(() {
            images = imageList;
          });
        });
      } else if (dropdownValue == 'Videos') {
        GetAssets().getVideosPath().then((List<String> videoList) {
          setState(() {
            videos = videoList;
          });
        });
      } else {
        GetAssets().getImagesPath(newValue).then((List<String> imageList) {
          setState(() {
            images = imageList;
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    GetAssets().getImagesPath(null).then((List<String> imageList) {
      setState(() {
        images = imageList;
      });
    });
    GetAssets().getVideosPath().then((List<String> videoList) {
      setState(() {
        videos = videoList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Short Video'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const MyHorizontalListview(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyDropDownButton(
                        value: dropdownValue,
                        onChanged: updateSelectedValue,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: isMultipleSelect
                                ? MaterialStateProperty.all<Color>(Colors.blue)
                                : MaterialStateProperty.all<Color>(
                                    Colors.grey)),
                        child: const Text(
                          "Pick multiple images",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          setState(() {
                            isMultipleSelect = !isMultipleSelect;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: dropdownValue == 'Gallery'
                ? MyDisplayGallery(
                    images: images,
                    videos: videos,
                    isMultipleselect: isMultipleSelect)
                : dropdownValue == 'Videos'
                    ? MyDisplayVideo(
                        videos: videos,
                        isMultipleselect: isMultipleSelect,
                      )
                    : MyDisplayImage(
                        images: images,
                        isMultipleselect: isMultipleSelect,
                      ),
          ),
        ],
      ),
    );
  }
}
