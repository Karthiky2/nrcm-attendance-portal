import 'package:flutter/material.dart';
import '../data/branch_data.dart';
import '../data/timetable_data.dart';
import 'period_subject_screen.dart';

/// STEP 2 & 3: Choose Engineering Year -> Branch -> Section.
class YearBranchSectionScreen extends StatefulWidget {
  const YearBranchSectionScreen({super.key});

  @override
  State<YearBranchSectionScreen> createState() =>
      _YearBranchSectionScreenState();
}

class _YearBranchSectionScreenState extends State<YearBranchSectionScreen> {
  String? _selectedYear;
  String? _selectedBranch;
  String? _selectedSection;

  List<String> get _availableSections =>
      _selectedBranch == null ? [] : kBranchSections[_selectedBranch]!;

  bool get _canContinue =>
      _selectedYear != null && _selectedBranch != null && _selectedSection != null;

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PeriodSubjectScreen(
          year: _selectedYear!,
          branch: _selectedBranch!,
          section: _selectedSection!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Class')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _sectionLabel('Engineering Year'),
            _chipGroup(
              options: kYears,
              selected: _selectedYear,
              onSelected: (v) => setState(() => _selectedYear = v),
            ),
            const SizedBox(height: 24),
            _sectionLabel('Branch'),
            _chipGroup(
              options: kBranchSections.keys.toList(),
              selected: _selectedBranch,
              onSelected: (v) => setState(() {
                _selectedBranch = v;
                _selectedSection = null; // reset section on branch change
              }),
            ),
            const SizedBox(height: 24),
            if (_selectedBranch != null) ...[
              _sectionLabel('Section'),
              _chipGroup(
                options: _availableSections,
                selected: _selectedSection,
                onSelected: (v) => setState(() => _selectedSection = v),
              ),
            ],
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canContinue ? _continue : null,
                child: const Text('CONTINUE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );

  Widget _chipGroup({
    required List<String> options,
    required String? selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = option == selected;
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => onSelected(option),
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
    );
  }
}
