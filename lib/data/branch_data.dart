/// ---------------------------------------------------------------------
/// BRANCHES & SECTIONS CONFIG
/// ---------------------------------------------------------------------
/// CSE has 7 sections (A-G) as requested. Other common branches are
/// included with 3 sections each by default - add/remove branches or
/// change section counts here, nothing else in the app needs to change.
const Map<String, List<String>> kBranchSections = {
  'CSE': ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
  'ECE': ['A', 'B', 'C'],
  'EEE': ['A', 'B', 'C'],
  'MECH': ['A', 'B'],
  'CIVIL': ['A', 'B'],
  'IT': ['A', 'B', 'C'],
};

const List<String> kYears = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
