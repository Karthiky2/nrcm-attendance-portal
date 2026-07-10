/// Represents one teaching period in the daily timetable.
class PeriodInfo {
  final int periodNumber; // 1-6
  final String timeRange; // e.g. "9:30 AM - 10:20 AM"

  const PeriodInfo({required this.periodNumber, required this.timeRange});
}

/// ---------------------------------------------------------------------
/// DAILY TIMETABLE (6 teaching periods + a lunch break)
/// ---------------------------------------------------------------------
/// Taken directly from the official class timetable photo provided.
const List<PeriodInfo> kDailyPeriods = [
  PeriodInfo(periodNumber: 1, timeRange: '9:30 AM - 10:30 AM'),
  PeriodInfo(periodNumber: 2, timeRange: '10:30 AM - 11:30 AM'),
  PeriodInfo(periodNumber: 3, timeRange: '11:30 AM - 12:30 PM'),
  // 12:30 PM - 1:20 PM  ->  LUNCH BREAK (not a selectable period)
  PeriodInfo(periodNumber: 4, timeRange: '1:20 PM - 2:20 PM'),
  PeriodInfo(periodNumber: 5, timeRange: '2:20 PM - 3:10 PM'),
  PeriodInfo(periodNumber: 6, timeRange: '3:10 PM - 4:00 PM'),
];
