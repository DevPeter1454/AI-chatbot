import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DownloadService {
  // Future downloadFile(String url, String savePath) async {
  //   var request = http.Request('GET', Uri.parse(url));
  //   var response = await request.send();
  //   var bytes = await http.ByteStream(response.stream).toBytes();
  //   var file = await File(savePath).writeAsBytes(bytes);
  //   return file;
  // }

  Future downloadImage(String url, {required String fileName}) async {
    var request = http.Request('GET', Uri.parse(url));
    var response = await request.send();
    var bytes = await http.ByteStream(response.stream).toBytes();
    final result = await ImageGallerySaver.saveImage(bytes, name: fileName);

    return result['isSuccess'];
  }
}
