import 'dart:async';
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
class FileData{

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
  Future<String> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return (contents);
    }
    catch (e) { return "";}
  }
  Future<File> writeCounter(String counter) async {
    final file = await _localFile;
    return file.writeAsString(counter);
  }


}