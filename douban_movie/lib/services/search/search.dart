import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SearchService {

  Future<String> readRecentSearch() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return contents;
    } on FileSystemException {
      return '';
    }
  }

  Future saveInput(String value) async {
    await (await _getLocalFile()).writeAsString('$value');
  }

  void clear() async {
    (await _getLocalFile()).delete();
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/search.txt');
  }

}