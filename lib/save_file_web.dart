// lib/save_file_web.dart
// Used only when running in a browser (flutter run -d chrome).

import 'dart:html' as html;

Future<String> saveExcelFile(List<int> bytes, String fileName) async {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = fileName;

  html.document.body!.children.add(anchor);
  anchor.click();
  html.document.body!.children.remove(anchor);
  html.Url.revokeObjectUrl(url);

  return 'your Downloads folder as $fileName';
}