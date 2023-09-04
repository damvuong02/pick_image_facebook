import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'dart:convert';

class GetAssets {
  Future<List<String>> getImagesPath(String? folder) async {
    var imagePath = await StoragePath.imagesPath;
    //trả ra 1 list trong list gồm nhiều map, mỗi map có định dạng {file: [(String)]}
    var decodedPath = jsonDecode(imagePath!) as List<dynamic>;

    List<String> images = [];
    if (folder == null) {
      //lấy tất cả ảnh trong thư viện
      for (var map in decodedPath) {
        var files = map['files'] as List<dynamic>;
        for (var file in files) {
          images.add(file);
        }
      }
    } else {
      //lấy ảnh theo loại
      for (var map in decodedPath) {
        if (map['folderName'] == folder) {
          var files = map['files'] as List<dynamic>;
          for (var file in files) {
            images.add(file);
          }
        }
      }
    }

    return images;
  }

  Future<List<String>> getVideosPath() async {
    var videoPath = await StoragePath.videoPath;
    var decodedPath = jsonDecode(videoPath!) as List<dynamic>;

    List<String> images = [];

    for (var map in decodedPath) {
      var files = map['files'] as List<dynamic>;
      for (var file in files) {
        var path = file['path'] as String;
        images.add(path);
      }
    }

    return images;
  }
}
