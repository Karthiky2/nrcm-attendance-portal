/// ---------------------------------------------------------------------
/// COURSE LIST & WEEKLY TIMETABLE
/// ---------------------------------------------------------------------
/// Extracted directly from the official timetable + course list photo
/// provided for CSE (this semester). If this timetable changes next
/// semester, or you want to reuse the app for another branch/year,
/// this is the only file you need to edit.

class Course {
  final String code;
  final String title;
  final String faculty; // comma separated if more than one faculty
  final String room;

  const Course({
    required this.code,
    required this.title,
    required this.faculty,
    required this.room,
  });
}

/// Short keys used internally to link a timetable slot -> its Course.
const String _daa = 'DAA';
const String _cn = 'CN';
const String _devops = 'DEVOPS';
const String _ppl = 'PPL';
const String _irs = 'IRS';
const String _cnLab = 'CN_LAB';
const String _devopsLab = 'DEVOPS_LAB';
const String _aecsLab = 'AECS_LAB';
const String _uiFlutterLab = 'UI_FLUTTER_LAB';
const String _ipr = 'IPR';

/// Full course details, keyed by the short code above.
const Map<String, Course> kCourses = {
  _daa: Course(
    code: '23CS501',
    title: 'Design and Analysis of Algorithms',
    faculty: 'Mr. Mohd Nawazuddin',
    room: 'TP-110',
  ),
  _cn: Course(
    code: '23CS502',
    title: 'Computer Networks',
    faculty: 'Mrs. Mounika',
    room: 'TP-110',
  ),
  _devops: Course(
    code: '23CS503',
    title: 'Dev Ops',
    faculty: 'Mr. P Thirupathi',
    room: 'TP-110',
  ),
  _ppl: Course(
    code: '23CS508',
    title: 'Principles of Programming Languages',
    faculty: 'Mrs. R Jeevitha',
    room: 'TP-110',
  ),
  _irs: Course(
    code: '23CS511',
    title: 'Information Retrieval Systems',
    faculty: 'Mrs. P Chaitanya',
    room: 'TP-110',
  ),
  _cnLab: Course(
    code: '23CS514',
    title: 'Computer Networks Lab',
    faculty: 'Mrs. Mounika, Mrs. J Swathi',
    room: 'ITP-302',
  ),
  _devopsLab: Course(
    code: '23CS515',
    title: 'Dev Ops Lab',
    faculty: 'Mr. P Thirupathi, Mrs. P Chaitanya',
    room: 'ITP-306',
  ),
  _aecsLab: Course(
    code: '23EN508',
    title: 'Advanced English Communication Skills Lab',
    faculty: 'Mrs. P Mamtha',
    room: 'ITP-304',
  ),
  _uiFlutterLab: Course(
    code: '23CS517',
    title: 'UI design - Flutter',
    faculty: 'Mrs. K Lavanya, Mr. Pruthvi Raj B',
    room: 'ITP-303',
  ),
  _ipr: Course(
    code: '*MC5001',
    title: 'Intellectual Property Rights',
    faculty: '',
    room: 'TP-110',
  ),
};

/// Dropdown list of all subjects (by their short code) for manual
/// selection - used as a fallback if a faculty wants to pick a subject
/// that isn't the auto-suggested one for that day/period (e.g. an
/// extra/substitute class).
const List<String> kSubjectCodes = [
  _daa,
  _cn,
  _devops,
  _ppl,
  _irs,
  _cnLab,
  _devopsLab,
  _aecsLab,
  _uiFlutterLab,
  _ipr,
];

const List<String> kWeekDays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

/// Which subject runs in each of the 6 periods, for every day.
/// (Lab sessions occupy 3 consecutive periods with the same subject.)
const Map<String, List<String>> kWeeklyTimetable = {
  'Monday': [_irs, _ppl, _cn, _devopsLab, _devopsLab, _devopsLab],
  'Tuesday': [_uiFlutterLab, _uiFlutterLab, _uiFlutterLab, _daa, _devops, _ppl],
  'Wednesday': [_cn, _devops, _daa, _aecsLab, _aecsLab, _aecsLab],
  'Thursday': [_cnLab, _cnLab, _cnLab, _devops, _irs, _ppl],
  'Friday': [_daa, _devops, _cn, _irs, _devops, _ppl],
  'Saturday': [_cn, _irs, _daa, _irs, _ppl, _daa],
};

/// Convenience: friendly display label for a course code, e.g.
/// "23CS501 - Design and Analysis of Algorithms".
String courseDisplayLabel(String shortCode) {
  final c = kCourses[shortCode];
  if (c == null) return shortCode;
  return '${c.code} - ${c.title}';
}
