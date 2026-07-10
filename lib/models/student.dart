class Student {
  final String? docId;
  final String id;
  final String name;
  final String year;
  final String branch;
  final String section;
  bool isPresent;

  Student({
    this.docId,
    required this.id,
    required this.name,
    required this.year,
    required this.branch,
    required this.section,
    this.isPresent = true,
  });
}