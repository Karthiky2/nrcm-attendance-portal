import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import '../models/student.dart';
import '../save_file.dart';
import '../data/student_repository.dart';

class AttendanceScreen extends StatefulWidget {
  final String year;
  final String branch;
  final String section;
  final String periodLabel;
  final String subject;
  final String faculty;

  const AttendanceScreen({
    super.key,
    required this.year,
    required this.branch,
    required this.section,
    required this.periodLabel,
    required this.subject,
    required this.faculty,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Student> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    // Loads from the local hardcoded roster in student_repository.dart
    // instead of Firestore. Add more "if" branches below as you add
    // more getXxxStudents() functions for other sections.
    List<Student> result = [];

    if (widget.year == '3rd Year' && widget.branch == 'CSE' && widget.section == 'G') {
      result = getCseSectionGStudents();
    }

    setState(() {
      students = result;
      isLoading = false;
    });
  }

  void _toggleAll(bool present) {
    setState(() {
      for (var s in students) {
        s.isPresent = present;
      }
    });
  }

  Future<void> _exportToExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['Attendance'];

    // Header rows
    sheet.appendRow([
      TextCellValue('NARSIMHA REDDY ENGINEERING COLLEGE'),
    ]);
    sheet.appendRow([
      TextCellValue('Attendance Report'),
    ]);
    sheet.appendRow([
      TextCellValue('Date: ${DateTime.now().toString().split(' ')[0]}'),
    ]);
    sheet.appendRow([
      TextCellValue('${widget.year} | ${widget.branch} | Section ${widget.section}'),
    ]);
    sheet.appendRow([
      TextCellValue('Period: ${widget.periodLabel}'),
    ]);
    sheet.appendRow([
      TextCellValue('Subject: ${widget.subject}'),
    ]);
    sheet.appendRow([
      TextCellValue('Faculty: ${widget.faculty}'),
    ]);
    sheet.appendRow([]); // empty row

    // Column headers
    sheet.appendRow([
      TextCellValue('S.No'),
      TextCellValue('Roll Number'),
      TextCellValue('Student Name'),
      TextCellValue('Status'),
    ]);

    // Student data
    for (int i = 0; i < students.length; i++) {
      sheet.appendRow([
        IntCellValue(i + 1),
        TextCellValue(students[i].id),
        TextCellValue(students[i].name),
        TextCellValue(students[i].isPresent ? 'PRESENT' : 'ABSENT'),
      ]);
    }

    // Summary
    final presentCount = students.where((s) => s.isPresent).length;
    final absentCount = students.length - presentCount;
    sheet.appendRow([]);
    sheet.appendRow([
      TextCellValue('Total Students:'),
      IntCellValue(students.length),
    ]);
    sheet.appendRow([
      TextCellValue('Present:'),
      IntCellValue(presentCount),
    ]);
    sheet.appendRow([
      TextCellValue('Absent:'),
      IntCellValue(absentCount),
    ]);

    // Remove default Sheet1 if it exists
    if (excel.sheets.containsKey('Sheet1')) {
      excel.delete('Sheet1');
    }

    final bytes = excel.encode();
    if (bytes == null) return;

    final date = DateTime.now().toString().split(' ')[0];
    final fileName =
        'Attendance_${widget.branch}_${widget.section}_${date}.xlsx';

    try {
      final path = await saveExcelFile(bytes, fileName);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Excel saved: $path'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving file: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final presentCount = students.where((s) => s.isPresent).length;
    final absentCount = students.length - presentCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: 'Mark All Present',
            onPressed: () => _toggleAll(true),
          ),
          IconButton(
            icon: const Icon(Icons.cancel_outlined),
            tooltip: 'Mark All Absent',
            onPressed: () => _toggleAll(false),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : students.isEmpty
          ? const Center(
        child: Text(
          'No students found.\nAdd students via Admin panel first.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : Column(
        children: [
          // Info card
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.year} • ${widget.branch} • Section ${widget.section}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.periodLabel,
                      style: const TextStyle(fontSize: 13)),
                  Text('Subject: ${widget.subject}',
                      style: const TextStyle(fontSize: 13)),
                  Text('Faculty: ${widget.faculty}',
                      style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _statusChip('Present: $presentCount', Colors.green),
                      const SizedBox(width: 10),
                      _statusChip('Absent: $absentCount', Colors.red),
                      const SizedBox(width: 10),
                      _statusChip('Total: ${students.length}', Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Student list
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: student.isPresent
                          ? Colors.green
                          : Colors.red,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(student.name),
                    subtitle: Text(student.id),
                    trailing: Switch(
                      value: student.isPresent,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (val) {
                        setState(() => student.isPresent = val);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: students.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: _exportToExcel,
          icon: const Icon(Icons.download),
          label: const Text('EXPORT TO EXCEL'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6B103D),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String label, Color color) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}