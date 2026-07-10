# Attendance Portal — Narshima Reddy Engineering College

A Flutter app for faculty to take daily class attendance and save it into an
Excel (.xlsx) file, organized by date, time, period, subject and faculty.

## App Flow (matches your spec)
1. **Login screen** — faculty logs in.
2. **Year → Branch → Section screen** — pick 1st–4th year, branch (CSE has
   all 7 sections A–G), then section.
3. **Day & Period screen** — pick the day and which of the 6 daily periods
   this is. Subject, faculty, and room auto-fill from the real class
   timetable (editable, e.g. for a substitute or extra class).
4. **Attendance screen** — every student defaults to ✅ Present; tap the
   checkbox to mark someone Absent. Shows Student Name + Student ID.
5. **Submit button** at the bottom →
   - Popup 1: "Are you sure you want to submit?"
   - Popup 2: shows the list of Absent students (name + ID) for a final check.
6. On confirm, everything is appended as new rows into
   `Attendance_Records.xlsx` on the device, with Date, Time, Year, Branch,
   Section, Period, Subject, Faculty, Roll No, Name, and Status — and you
   can immediately share/export that file.

## How to Run
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. From this project folder, run:
   ```
   flutter pub get
   flutter run
   ```
3. To build a release APK:
   ```
   flutter build apk --release
   ```
   The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

## Things You'll Likely Want to Customize

| What | File |
|---|---|
| College name / login screen text | `lib/screens/login_screen.dart` |
| Real login check (replace demo check) | `lib/screens/login_screen.dart` → `_handleLogin()` |
| Branches & number of sections per branch | `lib/data/branch_data.dart` |
| Real student roster (names & roll numbers) | `lib/data/student_repository.dart` |
| Daily period timings (6 classes) | `lib/models/period_info.dart` → `kDailyPeriods` |
| Courses, faculty, room, weekly timetable | `lib/data/timetable_data.dart` |
| App colors/theme | `lib/theme/app_theme.dart` |
| Excel column layout / file name | `lib/services/excel_service.dart` |

### About the timetable
`lib/data/timetable_data.dart` now has your real CSE timetable and course
list from the photo you shared: DAA, Computer Networks, Dev Ops, PPL, IRS,
plus the CN Lab / Dev Ops Lab / AECS Lab / UI-Flutter Lab sessions, each
with their course code, faculty, and room — mapped Monday–Saturday across
all 6 periods. Picking a day + period on the "Select Period & Subject"
screen auto-fills the subject, faculty, and room; the faculty name can
still be edited by hand for substitutions.

Note: this timetable was given for one class (CSE), so right now it
applies the same way regardless of which year/branch/section you pick in
step 2. If you need different timetables per year or branch, you can
extend `kWeeklyTimetable` in that file to be keyed by year/branch too.

### About the student list
There's no real student roster available yet, so `student_repository.dart`
auto-generates 30 placeholder students per section (Student 1, Student 2, ...).
Replace `StudentRepository.getStudents()` with your actual class lists (or
load them from a CSV/Excel file — the `excel` package is already a
dependency) whenever you have the real data.

## Where the Excel file is saved
The app writes to the app's private Documents directory on the device
(via `path_provider`). Use the **SHARE FILE** button after saving to export
it to email, Google Drive, WhatsApp, etc. — since it's a private app folder,
you can't browse to it directly from a file manager.

## Packages Used
- `excel` — creating/appending to the .xlsx attendance file
- `path_provider` — locating a safe folder to store the file
- `share_plus` — sharing/exporting the Excel file
- `intl` — formatting date & time
