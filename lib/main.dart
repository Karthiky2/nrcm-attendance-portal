// lib/main.dart

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'models/student.dart';
import 'data/student_repository.dart';
import 'save_file.dart'; // Handles saving on web vs mobile/desktop automatically

const String kAdminPassword = 'nrcm2026';

void main() {
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Portal',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// STEP 1: LOGIN PAGE
// ==========================================
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _login() {
    if (_userController.text.isNotEmpty && _passController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectionScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Username and Password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/college_campus.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.45)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/nrcm_logo.jpeg',
                          height: 110,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'NARSIMHA REDDY ENGINEERING COLLEGE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.black87, blurRadius: 6, offset: Offset(0, 1)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'EMPLOYEE LOGIN',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _userController,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 22),
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('LOGIN', style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// STEP 2 & 3: SELECTION SCREEN
// ==========================================
class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String? selectedYear;
  String? selectedBranch;
  String? selectedSection;
  String? selectedPeriod;
  String? selectedSubjectFaculty;

  final List<String> years = ['1', '2', '3', '4'];
  final List<String> branches = ['CSE', 'ECE', 'EEE', 'MECH', 'CIVIL'];
  final List<String> sections = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

  final List<String> periods = [
    'Period 1 (9:30AM - 10:30AM)',
    'Period 2 (10:30AM - 11:30AM)',
    'Period 3 (11:30AM - 12:30PM)',
    'Period 4 (1:20PM - 2:20PM)',
    'Period 5 (2:20PM - 3:10PM)',
    'Period 6 (3:10PM - 4:00PM)'
  ];

  final List<String> facultySubjects = [
    'DAA - Mr. Mohd Nawazuddin',
    'Computer Networks - Mrs. Mounika',
    'Dev Ops - Mr. P Thirupathi',
    'PPL - Mrs. R Jeevitha',
    'IRS - Mrs. P Chaitanya',
    'CN Lab - Mrs. Mounika & Mrs. J Swathi',
    'Dev Ops Lab - Mr. P Thirupathi & Mrs. P Chaitanya',
    'AECS Lab - Mrs. P Mamtha',
    'UI design-Flutter - Mrs. K Lavanya & Mr. Pruthvi Raj B',
  ];

  void _openAdminLogin() {
    final passController = TextEditingController();
    String? error;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Admin Login'),
              content: TextField(
                controller: passController,
                obscureText: true,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Admin Password',
                  border: const OutlineInputBorder(),
                  errorText: error,
                ),
                onSubmitted: (_) {
                  if (passController.text == kAdminPassword) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
                    );
                  } else {
                    setDialogState(() => error = 'Incorrect password');
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (passController.text == kAdminPassword) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
                      );
                    } else {
                      setDialogState(() => error = 'Incorrect password');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/college_campus.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.45)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      const Expanded(
                        child: Text(
                          'Select Class Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(color: Colors.black87, blurRadius: 6)],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
                        tooltip: 'Admin',
                        onPressed: _openAdminLogin,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/images/nrcm_logo.jpeg',
                                height: 70,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.94),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildDropdown('Engineering Year', Icons.school_outlined, years, selectedYear, (v) => setState(() => selectedYear = v)),
                                  const SizedBox(height: 14),
                                  _buildDropdown('Branch', Icons.account_tree_outlined, branches, selectedBranch, (v) => setState(() => selectedBranch = v)),
                                  const SizedBox(height: 14),
                                  _buildDropdown('Section', Icons.groups_outlined, sections, selectedSection, (v) => setState(() => selectedSection = v)),
                                  const SizedBox(height: 14),
                                  _buildDropdown('Period & Timing', Icons.schedule_outlined, periods, selectedPeriod, (v) => setState(() => selectedPeriod = v)),
                                  const SizedBox(height: 14),
                                  _buildDropdown('Subject & Faculty', Icons.menu_book_outlined, facultySubjects, selectedSubjectFaculty, (v) => setState(() => selectedSubjectFaculty = v)),
                                  const SizedBox(height: 26),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (selectedYear != null && selectedBranch != null && selectedSection != null && selectedPeriod != null && selectedSubjectFaculty != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AttendanceScreen(
                                              year: selectedYear!,
                                              branch: selectedBranch!,
                                              section: selectedSection!,
                                              period: selectedPeriod!,
                                              subjectInfo: selectedSubjectFaculty!,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please select all fields')),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                    label: const Text('PROCEED TO ATTENDANCE', style: TextStyle(fontSize: 16)),
                                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 52)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, IconData icon, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      value: value,
      isExpanded: true,
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, overflow: TextOverflow.ellipsis))).toList(),
      onChanged: onChanged,
    );
  }
}

// ==========================================
// ADMIN PANEL — bulk add students (in-memory, no lag)
// ==========================================
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  String selectedYear = '3';
  String selectedBranch = 'CSE';
  String selectedSection = 'G';

  final List<String> years = ['1', '2', '3', '4'];
  final List<String> branches = ['CSE', 'ECE', 'EEE', 'MECH', 'CIVIL'];
  final List<String> sections = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

  final TextEditingController _bulkController = TextEditingController();
  List<Student> _justAdded = [];

  void _bulkAdd() {
    final lines = _bulkController.text.split('\n');
    final List<Student> parsed = [];
    final List<String> skipped = [];

    for (var rawLine in lines) {
      var line = rawLine.trim();
      if (line.isEmpty) continue;

      // Accepts "ID, Name", "ID - Name", "ID: Name", or "ID  Name"
      final match = RegExp(r'^([A-Za-z0-9]+)\s*[:,\-]\s*(.+)$').firstMatch(line) ??
          RegExp(r'^(\S+)\s+(.+)$').firstMatch(line);

      if (match != null) {
        final id = match.group(1)!.trim();
        final name = match.group(2)!.trim().toUpperCase();
        if (id.isNotEmpty && name.isNotEmpty) {
          parsed.add(Student(
            id: id,
            name: name,
            year: selectedYear,
            branch: selectedBranch,
            section: selectedSection,
          ));
          continue;
        }
      }
      skipped.add(line);
    }

    if (parsed.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No valid lines found. Use format: ID, Name (one per line)')),
      );
      return;
    }

    // Instant — just appends to an in-memory list, no network call, no lag.
    addSessionStudents(parsed);

    setState(() {
      _justAdded = parsed;
      _bulkController.clear();
    });

    String message = 'Added ${parsed.length} students to $selectedYear / $selectedBranch / $selectedSection';
    if (skipped.isNotEmpty) {
      message += '. Skipped ${skipped.length} line(s) that didn\'t match the format.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  String _shortId(String id) {
    if (id.length <= 4) return id;
    return id.substring(id.length - 4);
  }

  // Downloads a ready-to-paste Dart snippet with every student added this
  // session, grouped by year/branch/section. Paste the output into
  // lib/data/student_repository.dart to make the roster permanent.
  Future<void> _exportSessionRoster() async {
    final sessionStudents = getSessionStudents();
    if (sessionStudents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No students added this session yet.')),
      );
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('// Paste this into lib/data/student_repository.dart');
    buffer.writeln('// (either inside getRosterFor() as a new "if" branch,');
    buffer.writeln('// or as its own getXxxStudents() function.)\n');

    // Group by year/branch/section for readability
    final Map<String, List<Student>> grouped = {};
    for (final s in sessionStudents) {
      final key = '${s.year}_${s.branch}_${s.section}';
      grouped.putIfAbsent(key, () => []).add(s);
    }

    for (final entry in grouped.entries) {
      final parts = entry.key.split('_');
      buffer.writeln('// Year ${parts[0]} / ${parts[1]} / Section ${parts[2]}');
      for (final s in entry.value) {
        buffer.writeln(
          "Student(id: '${s.id}', name: '${s.name}', year: '${s.year}', branch: '${s.branch}', section: '${s.section}'),",
        );
      }
      buffer.writeln();
    }

    final bytes = buffer.toString().codeUnits;
    final savedLocation = await saveExcelFile(bytes, 'session_roster_export.txt');

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Roster exported: $savedLocation')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin: Bulk Add Students')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Year', border: OutlineInputBorder()),
                    value: selectedYear,
                    items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                    onChanged: (v) => setState(() => selectedYear = v!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Branch', border: OutlineInputBorder()),
                    value: selectedBranch,
                    items: branches.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (v) => setState(() => selectedBranch = v!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Section', border: OutlineInputBorder()),
                    value: selectedSection,
                    items: sections.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => selectedSection = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bulk Add (paste a list, one student per line)',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Format: ID, Name  — e.g.  24X01A05Z7, RAVI MEHAR PHANEENDRA\nWill be added instantly to $selectedYear / $selectedBranch / $selectedSection.",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _bulkController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '24X01A05Z7, RAVI MEHAR PHANEENDRA\n24X01A05Z8, RAYAM GEETHA PRASANNA\n24X01A05Z9, RAYAPURAM ASHWINI',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _bulkAdd,
              icon: const Icon(Icons.playlist_add),
              label: Text('Add to $selectedYear / $selectedBranch / $selectedSection'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _exportSessionRoster,
              icon: const Icon(Icons.download),
              label: const Text('Export Session Roster (to make it permanent)'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 44)),
            ),
            if (_justAdded.isNotEmpty) ...[
              const Divider(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Just added (${_justAdded.length}):',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  itemCount: _justAdded.length,
                  itemBuilder: (context, index) {
                    final s = _justAdded[index];
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.check_circle, color: Colors.green, size: 18),
                      title: Text(s.name, style: const TextStyle(fontSize: 13)),
                      subtitle: Text('ID: ${_shortId(s.id)}', style: const TextStyle(fontSize: 11)),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// STEP 4 & 5: ATTENDANCE SHEET & CHECKBOXES
// ==========================================
class AttendanceScreen extends StatefulWidget {
  final String year;
  final String branch;
  final String section;
  final String period;
  final String subjectInfo;

  const AttendanceScreen({
    Key? key,
    required this.year,
    required this.branch,
    required this.section,
    required this.period,
    required this.subjectInfo,
  }) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Student> students = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  // Instant lookup — no network, no lag. Pulls from both the permanent
  // hardcoded rosters and anything added this session via the Admin Panel.
  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);
    final result = getRosterFor(widget.year, widget.branch, widget.section);
    setState(() {
      students = result;
      _isLoading = false;
    });
  }

  void _toggleAll(bool? value) {
    setState(() {
      for (var student in students) {
        student.isPresent = value ?? false;
      }
    });
  }

  String _shortId(String id) {
    if (id.length <= 4) return id;
    return id.substring(id.length - 4);
  }

  void _submitAttendance() {
    if (students.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Submission"),
          content: const Text("Are you sure you want to submit?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showAbsentStudents();
              },
              child: const Text("Yes, Submit"),
            ),
          ],
        );
      },
    );
  }

  void _showAbsentStudents() {
    List<Student> absentStudents = students.where((s) => !s.isPresent).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Absent Students"),
          content: SizedBox(
            width: double.maxFinite,
            child: absentStudents.isEmpty
                ? const Text("No students are absent.")
                : ListView.builder(
              shrinkWrap: true,
              itemCount: absentStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(absentStudents[index].name),
                  subtitle: Text("ID: ${_shortId(absentStudents[index].id)}"),
                  leading: const Icon(Icons.person_off, color: Colors.red),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _exportToExcel();
              },
              child: const Text("Confirm & Export to Excel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportToExcel() async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Attendance'];
      excel.setDefaultSheet('Attendance');

      sheetObject.appendRow([TextCellValue('${widget.branch} - Section ${widget.section}')]);
      sheetObject.appendRow([TextCellValue(widget.subjectInfo)]);
      sheetObject.appendRow([TextCellValue(widget.period)]);
      sheetObject.appendRow([]);

      final presentStudents = students.where((s) => s.isPresent).toList();
      final absentStudents = students.where((s) => !s.isPresent).toList();

      sheetObject.appendRow([TextCellValue('PRESENT (${presentStudents.length})')]);
      sheetObject.appendRow([
        TextCellValue('Student ID'),
        TextCellValue('Student Name'),
      ]);
      for (var student in presentStudents) {
        sheetObject.appendRow([
          TextCellValue(_shortId(student.id)),
          TextCellValue(student.name),
        ]);
      }

      sheetObject.appendRow([]);

      sheetObject.appendRow([TextCellValue('ABSENT (${absentStudents.length})')]);
      sheetObject.appendRow([
        TextCellValue('Student ID'),
        TextCellValue('Student Name'),
      ]);
      for (var student in absentStudents) {
        sheetObject.appendRow([
          TextCellValue(_shortId(student.id)),
          TextCellValue(student.name),
        ]);
      }

      String currentDate = DateTime.now().toString().split(' ')[0];
      String fileName = 'Attendance_${widget.branch}_${widget.section}_$currentDate.xlsx';
      String savedLocation = await saveExcelFile(excel.encode()!, fileName);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Excel File Saved: $savedLocation')),
      );

      Navigator.pop(context);

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving Excel: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch} - Sec ${widget.section} Attendance'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.subjectInfo}\n${widget.period}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          if (!_isLoading && students.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mark All Present", style: TextStyle(fontWeight: FontWeight.bold)),
                  Switch(
                    value: students.every((s) => s.isPresent),
                    onChanged: _toggleAll,
                  ),
                ],
              ),
            ),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : students.isEmpty
                ? Center(
              child: Text(
                'No student data available for ${widget.branch} - Sec ${widget.section}.\nAdd students via the Admin panel first.',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  students[index].name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                              ),
                              const SizedBox(height: 4),
                              Text(
                                  'ID: ${_shortId(students[index].id)}',
                                  style: const TextStyle(color: Colors.grey, fontSize: 12)
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const Text("P", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            Checkbox(
                              value: students[index].isPresent,
                              activeColor: Colors.green,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  setState(() {
                                    students[index].isPresent = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text("A", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            Checkbox(
                              value: !students[index].isPresent,
                              activeColor: Colors.red,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  setState(() {
                                    students[index].isPresent = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (!_isLoading && students.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _submitAttendance,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('SUBMIT ATTENDANCE', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}