import 'package:flutter/material.dart';
import 'package:load_multiple_image/pick_image_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request storage permission
  await requestStoragePermission();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text("upload images"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PickImageScreen(),
              ));
        },
      ),
    );
  }
}

Future<bool> requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();
  return status.isGranted;
}
