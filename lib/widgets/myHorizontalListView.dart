import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:load_multiple_image/widgets/videoScreen.dart';

class MyHorizontalListview extends StatelessWidget {
  const MyHorizontalListview({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList = [
      {
        "icon": Icons.video_camera_back,
        "content": "Camera",
        "color": Colors.purple
      },
      {"icon": Icons.music_note, "content": "Music", "color": Colors.red},
      {"icon": Icons.pending_actions, "content": "Mẫu", "color": Colors.yellow},
      {"icon": Icons.star, "content": "Hiệu ứng", "color": Colors.green},
      {"icon": Icons.person, "content": "Phông xanh", "color": Colors.blue},
    ];
    final ImagePicker picker = ImagePicker();
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              // Build your list item widget here
              return MyHorizontalListviewItem(
                size: maxHeight,
                iconData: dataList[index]["icon"],
                content: dataList[index]["content"],
                colors: dataList[index]["color"],
                onTap: () async {
                  if (index == 0) {
                    final XFile? cameraVideo =
                        await picker.pickVideo(source: ImageSource.camera);
                    if (cameraVideo != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VideoScreen(videoFile: cameraVideo),
                          ));
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MyHorizontalListviewItem extends StatelessWidget {
  final double size;
  final IconData iconData;
  final String content;
  final Color colors;
  final void Function()? onTap;
  const MyHorizontalListviewItem(
      {super.key,
      required this.size,
      required this.iconData,
      required this.content,
      required this.colors,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colors,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: size,
        width: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 30,
            ),
            Text(content)
          ],
        ),
      ),
    );
  }
}
