// lib/save_file.dart
// Conditional export: picks the web implementation when compiled for the
// browser, and the io (path_provider) implementation everywhere else
// (Android, iOS, Windows, macOS, Linux).

export 'save_file_io.dart'
if (dart.library.html) 'save_file_web.dart';