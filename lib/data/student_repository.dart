import '../models/student.dart';

// ============================================================
// ROSTER REGISTRY
// ============================================================
// Each year/branch/section has its own roster function below.
// To add a new section's data permanently: paste a new function
// here (or in its own file under lib/data/rosters/ and import it),
// then register it in getRosterFor().
//
// Students added via the in-app Admin Panel are added to
// _sessionRoster below and are included automatically until the
// app restarts. Use "Export Roster" in the Admin Panel to download
// a .dart snippet you can paste in here to make them permanent.
// ============================================================

List<Student> getCseSectionGStudents() {
  return [
    Student(id: '24X01A05T5', name: 'NYAVANANDHI MEGHANA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05T6', name: 'ODDE ARAVIND', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05T7', name: 'OLLALA UDAY KIRAN', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05T8', name: 'ORSHU POOJITHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05T9', name: 'ORSU VENKATESH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U0', name: 'P V S B AKHILESH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U1', name: 'PABBA ARSHITH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U2', name: 'PABBA POOJITHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U3', name: 'PALAKURTHY JASHWANTH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U4', name: 'PALLE MANEESHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U5', name: 'PAMARTHI JAGADEESH KUMAR', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U6', name: 'PAMARTHY PRADEEP KUMAR', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U7', name: 'PANALA CHANDANA SUREKHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U8', name: 'PANDI VIVEK', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05U9', name: 'PANIGANTI HIMABINDU', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V0', name: 'PANTHULA ASHWANTH REDDY', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V1', name: 'PAPUNKA SIDDU', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V2', name: 'PARLAPELLY KRISHNA CHAITANYA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V3', name: 'PARVEDA DIVYA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V4', name: 'PATHI VISHNU', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V5', name: 'PATHIPAKA VINOD', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V6', name: 'PATHLOTH SURESH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V7', name: 'PATIL OMKAR', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V8', name: 'PATRA PRABHAKAR', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05V9', name: 'PAWAR AVINASH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W0', name: 'PEDDAGOLLA SHIVAKUMAR', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W1', name: 'PEDDI PRAVALIKA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W2', name: 'PEDDOLLA VISHNUVARDHAN', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W3', name: 'PENDALWAR NAMDEV', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W4', name: 'PENJARLA SAMPATH REDDY', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W5', name: 'PENTA ASHWANTH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W6', name: 'PERALA PRANAYA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05W9', name: 'PERUMANDLA SINDHU', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X0', name: 'PILLUTLA NITHIN REDDY', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X1', name: 'PINDI NIKHITHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X2', name: 'PIPPERA MANITHA REDDY', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X3', name: 'PISHKA GAYATHRI', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X4', name: 'PITLA HARINI', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X5', name: 'PITTALA AKSHAYA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X6', name: 'POCHARIGAN MANASA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X7', name: 'PODENDLA RAHUL YADAV', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X8', name: 'POGULA HARSHINI', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05X9', name: 'POLEPALLI NAGAVISHNU', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y0', name: 'POLISHETTY JATIN', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y1', name: 'POLSANI HARSHITHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y2', name: 'POTATI KARTHIK', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y3', name: 'POTTURI SAKETH SRI VARMA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y4', name: 'PUJALA SOMASEKHAR NAYUDU', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y5', name: 'PUNEM NAGAPRIYA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y6', name: 'PUNUGOTI JOSHIKA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y7', name: 'PUSHPENDAR', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y8', name: 'R BHAVYA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Y9', name: 'RACHAKOLLA SUSHMITHA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z0', name: 'RAGUTHU SURESH', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z1', name: 'RAMADASU SRI CHARAN', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z2', name: 'RAMGONDOLLA RAVI TEJA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z3', name: 'RAMISETTI DHATRI', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z4', name: 'RAMISETTI SAI SURYA TEJA KESHAV', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z5', name: 'RAPELLY SAI DATTA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z6', name: 'RATHNA JAGAN', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z7', name: 'RAVI MEHAR PHANEENDRA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z8', name: 'RAYAM GEETHA PRASANNA', year: '3', branch: 'CSE', section: 'G'),
    Student(id: '24X01A05Z9', name: 'RAYAPURAM ASHWINI', year: '3', branch: 'CSE', section: 'G'),
  ];
}

// ---- In-memory store for students added via the Admin Panel ----
// Lives for the lifetime of the running app (resets on full refresh/restart).
final List<Student> _sessionRoster = [];

void addSessionStudents(List<Student> students) {
  _sessionRoster.addAll(students);
}

List<Student> getSessionStudents() => List.unmodifiable(_sessionRoster);

// ---- Master lookup used by the whole app ----
// Combines the permanent hardcoded rosters above with anything added
// this session via the Admin Panel, filtered by year/branch/section.
List<Student> getRosterFor(String year, String branch, String section) {
  final List<Student> combined = [];

  if (year == '3' && branch == 'CSE' && section == 'G') {
    combined.addAll(getCseSectionGStudents());
  }

  combined.addAll(
    _sessionRoster.where((s) => s.year == year && s.branch == branch && s.section == section),
  );

  return combined;
}