import 'dart:io';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/student.dart';

/// Handles writing every submitted attendance session into a single
/// growing Excel workbook stored on the device
/// (Attendance_Records.xlsx), one new row per student per session.
class ExcelService {
  static const String _fileName = 'Attendance_Records.xlsx';
  static const String _sheetName = 'Attendance';

  static const List<String> _headers = [
    'Date',
    'Time',
    'Year',
    'Branch',
    'Section',
    'Period',
    'Subject',
    'Faculty',
    'Student Roll No',
    'Student Name',
    'Status',
  ];

  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  /// Appends one row per student for this session and returns the file.
  static Future<File> saveAttendance({
    required String year,
    required String branch,
    required String section,
    required String periodLabel,
    required String subject,
    required String faculty,
    required List<Student> students,
  }) async {
    final file = await _getFile();
    Excel excel;

    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      excel = Excel.decodeBytes(bytes);
    } else {
      excel = Excel.createExcel();
      // Excel package creates a default 'Sheet1' - remove it once
      // our real sheet exists to keep the workbook tidy.
    }

    if (!excel.sheets.containsKey(_sheetName)) {
      final sheet = excel[_sheetName];
      sheet.appendRow(_headers.map((h) => TextCellValue(h)).toList());
      if (excel.sheets.containsKey('Sheet1') && excel.sheets.length > 1) {
        excel.delete('Sheet1');
      }
    }

    final sheet = excel[_sheetName];

    final now = DateTime.now();
    final dateStr = DateFormat('dd-MM-yyyy').format(now);
    final timeStr = DateFormat('hh:mm a').format(now);

    for (final student in students) {
      sheet.appendRow([
        TextCellValue(dateStr),
        TextCellValue(timeStr),
        TextCellValue(year),
        TextCellValue(branch),
        TextCellValue(section),
        TextCellValue(periodLabel),
        TextCellValue(subject),
        TextCellValue(faculty),
        TextCellValue(student.rollNo),
        TextCellValue(student.name),
        TextCellValue(student.isPresent ? 'Present' : 'Absent'),
      ]);
    }

    final encoded = excel.encode();
    if (encoded != null) {
      await file.writeAsBytes(encoded);
    }
    return file;
  }

  /// Opens the native share sheet so faculty can send/export the
  /// Excel file (email, Drive, WhatsApp, etc).
  static Future<void> shareFile() async {
    final file = await _getFile();
    if (await file.exists()) {
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Attendance Records',
      );
    }
  }

  static Future<bool> fileExists() async {
    final file = await _getFile();
    return file.exists();
  }
}
