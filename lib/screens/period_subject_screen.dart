import 'package:flutter/material.dart';
import '../data/branch_data.dart';
import '../data/timetable_data.dart';
import '../models/period_info.dart';
import 'attendance_screen.dart';

/// Select Day -> Period (of the 6 daily classes). Subject, faculty and
/// room are auto-filled from the real weekly timetable, but can still
/// be overridden manually (e.g. for a substitute faculty or extra class).
class PeriodSubjectScreen extends StatefulWidget {
  final String year;
  final String branch;
  final String section;

  const PeriodSubjectScreen({
    super.key,
    required this.year,
    required this.branch,
    required this.section,
  });

  @override
  State<PeriodSubjectScreen> createState() => _PeriodSubjectScreenState();
}

class _PeriodSubjectScreenState extends State<PeriodSubjectScreen> {
  // Default to today if it's a weekday in the timetable, otherwise Monday.
  late String _selectedDay = _todayOrDefault();
  PeriodInfo? _selectedPeriod;
  String? _selectedSubjectCode;
  final _facultyController = TextEditingController();
  bool _facultyManuallyEdited = false;

  static String _todayOrDefault() {
    const names = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    final today = names[DateTime.now().weekday - 1];
    return kWeekDays.contains(today) ? today : 'Monday';
  }

  @override
  void dispose() {
    _facultyController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _selectedPeriod != null &&
      _selectedSubjectCode != null &&
      _facultyController.text.trim().isNotEmpty;

  /// Auto-fills subject + faculty for the chosen day/period from the
  /// real timetable, unless the faculty name was already hand-edited.
  void _autoFillFromTimetable() {
    if (_selectedPeriod == null) return;
    final daySlots = kWeeklyTimetable[_selectedDay];
    if (daySlots == null) return;
    final code = daySlots[_selectedPeriod!.periodNumber - 1];
    final course = kCourses[code];
    setState(() {
      _selectedSubjectCode = code;
      if (!_facultyManuallyEdited) {
        _facultyController.text = course?.faculty ?? '';
      }
    });
  }

  void _continue() {
    final course = kCourses[_selectedSubjectCode];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AttendanceScreen(
          year: widget.year,
          branch: widget.branch,
          section: widget.section,
          periodLabel:
              '$_selectedDay, Period ${_selectedPeriod!.periodNumber} (${_selectedPeriod!.timeRange})',
          subject: course != null
              ? '${course.code} - ${course.title}'
              : _selectedSubjectCode!,
          faculty: _facultyController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final course = kCourses[_selectedSubjectCode];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Period & Subject')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  '${widget.year}  •  ${widget.branch}  •  Section ${widget.section}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Day',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: kWeekDays.map((day) {
                final isSelected = day == _selectedDay;
                return ChoiceChip(
                  label: Text(day.substring(0, 3)),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() => _selectedDay = day);
                    _autoFillFromTimetable();
                  },
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text('Period (Total 6 classes/day)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: kDailyPeriods.map((p) {
                final isSelected = _selectedPeriod?.periodNumber == p.periodNumber;
                return InkWell(
                  onTap: () {
                    setState(() => _selectedPeriod = p);
                    _autoFillFromTimetable();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Period ${p.periodNumber}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.timeRange,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text('Subject',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text(
              'Auto-filled from the timetable for the day/period picked above - change it if this is a substitute or extra class.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedSubjectCode,
              decoration: const InputDecoration(hintText: 'Select subject'),
              isExpanded: true,
              items: kSubjectCodes
                  .map((code) => DropdownMenuItem(
                        value: code,
                        child: Text(
                          courseDisplayLabel(code),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  _selectedSubjectCode = v;
                  // Subject picked manually -> also refresh faculty
                  // suggestion for that subject (still editable).
                  _facultyManuallyEdited = false;
                  _facultyController.text = kCourses[v]?.faculty ?? '';
                });
              },
            ),
            if (course != null) ...[
              const SizedBox(height: 8),
              Text(
                'Room: ${course.room}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
            const SizedBox(height: 24),
            const Text('Faculty Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextField(
              controller: _facultyController,
              onChanged: (_) {
                _facultyManuallyEdited = true;
                setState(() {});
              },
              decoration: const InputDecoration(hintText: 'Faculty name'),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canContinue ? _continue : null,
                child: const Text('CONTINUE TO ATTENDANCE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
