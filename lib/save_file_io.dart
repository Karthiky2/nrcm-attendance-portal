import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveExcelFile(List<int> bytes, String fileName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  String filePath = '${directory.path}/$fileName';

  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);

  return filePath;
}