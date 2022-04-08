import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SaveUrl {
  Future<String> getLocalPath() async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  Future<File> getLocalFile() async {
    final path = await getLocalPath();
    print("$path/url.txt");
    return File('$path/url.txt');
  }

  Future<File> saveUrl(String url) async {
    final file = await getLocalFile();
    return file.writeAsString(url);
  }

  Future<String> readUrl() async {
    try {
      final file = await getLocalFile();

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "";
    }
  }
}

class Student {
  String? uid;
  String? name;
  String? branch;
  String? year;
  String? status;
  String? photo;
  Student(this.uid, this.name, this.branch, this.year, this.status, this.photo);
}
