import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../../models/user.dart';
import '../data/student_shared_preferences.dart';
import '../api/apis.dart';

// Notifier class that provides the logic for updating values
class StudentNotifier extends StateNotifier<Student> {
  // Add AsyncValues to track the loading states for various data
  AsyncValue<Map<String, dynamic>> timetableState = const AsyncValue.loading();
  AsyncValue<Map<String, dynamic>> attendanceState = const AsyncValue.loading();
  AsyncValue<List<Map<String, dynamic>>> marksState =
      const AsyncValue.loading();
  AsyncValue<Map<String, dynamic>> profileState = const AsyncValue.loading();

  StudentNotifier()
      : super(Student(
          name: '',
          regNo: '',
          profileImagePath: '',
          timetable: {},
          examSchedule: {},
          attendance: {},
          marks: [],
          isNotificationsEnabled: false,
          isPrivacyModeEnabled: false,
          notificationDelay: 0,
          profile: {},
        )) {
    _init(); // Load student from Shared Preferences initially
  }

  // Private async method to load student data
  Future<void> _init() async {
    await loadStudent(); // Load student from Shared Preferences
  }

  // Fetch and update timetable with loading indicator
  Future<void> fetchAndUpdateTimetable() async {
    timetableState = const AsyncValue.loading(); // Set to loading state
    state = state.copyWith(timetable: {}); // Clear existing timetable state

    try {
      final response = await fetchTimetable();
      if (response.statusCode == 200) {
        final timetableData = jsonDecode(response.body);
        updateTimetable(timetableData['timetable']);
        timetableState =
            AsyncValue.data(timetableData['timetable']); // Set data state
      } else {
        timetableState = AsyncValue.error(
            'Failed to fetch timetable: ${response.statusCode}',
            StackTrace.current);
      }
    } catch (e) {
      timetableState =
          AsyncValue.error('An error occurred: $e', StackTrace.current);
    }
  }

  // Fetch and update attendance with loading indicator
  Future<void> fetchAndUpdateAttendance() async {
    attendanceState = const AsyncValue.loading(); // Set to loading state
    state = state.copyWith(attendance: {}); // Clear existing attendance state

    try {
      final response = await fetchAttendanceData();
      if (response.statusCode == 200) {
        final attendanceData = jsonDecode(response.body);
        updateAttendance(attendanceData['attendance']);
        attendanceState =
            AsyncValue.data(attendanceData['attendance']); // Set data state
      } else {
        attendanceState = jsonDecode(response.body);
        log("${AsyncValue.error('Failed to fetch attendance: ${response.statusCode}', StackTrace.current)}");
      }
    } catch (e) {
      log("Error : $e , Stack : ${StackTrace.current}");
      attendanceState =
          AsyncValue.error('An error occurred: $e', StackTrace.current);
    }
  }

  // Fetch and update marks with loading indicator
  Future<void> fetchAndUpdateMarks() async {
    marksState = const AsyncValue.loading(); // Set to loading state
    state = state.copyWith(marks: []); // Clear existing marks state

    try {
      final response = await fetchMarks();
      if (response.statusCode == 200) {
        final marksData = jsonDecode(response.body);
        log("Marks raw data: $marksData");

        // Cast marksData['marks'] to List<Map<String, dynamic>>
        List<Map<String, dynamic>> marksList =
            List<Map<String, dynamic>>.from(marksData['marks']);

        updateMarks(marksList);
        marksState = AsyncValue.data(marksList);
      } else {
        marksState = AsyncValue.error(
            'Failed to fetch marks: ${response.statusCode}',
            StackTrace.current);
      }
    } catch (e) {
      log("Error: $e StackTrace ${StackTrace.current}");
      marksState =
          AsyncValue.error('An error occurred: $e', StackTrace.current);
    }
  }

  // Fetch and update profile with loading indicator
  Future<void> loginAndUpdateProfile(
      String username, String password, String semSubID) async {
    profileState = const AsyncValue.loading(); // Set to loading state

    try {
      final response = await fetchLoginData(username, password, semSubID);
      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        updateStudentProfile(profileData);
        profileState = AsyncValue.data(profileData); // Set data state
      } else {
        profileState = AsyncValue.error(
            'Login failed: ${response.statusCode}', StackTrace.current);
      }
    } catch (e) {
      profileState = AsyncValue.error(
          'An error occurred during login: $e', StackTrace.current);
    }
  }

  // Method to update the full student profile
  void updateStudentProfile(Map<String, dynamic> profileData) {
    state = state.copyWith(
      name: profileData['name'],
      regNo: profileData['regNo'],
      timetable: profileData['timetable'],
      attendance: profileData['attendance'],
      // Add more fields as necessary
    );
    saveStudentToPrefs(state); // Save updated profile to Shared Preferences
  }

  AsyncValue get attendanceStatee => attendanceState;

  // Method to update timetable
  void updateTimetable(Map<String, dynamic> timetable) {
    state = state.copyWith(timetable: timetable);
    saveStudentToPrefs(state);
  }

  // Method to update attendance
  void updateAttendance(Map<String, dynamic> attendance) {
    state = state.copyWith(attendance: attendance);
    saveStudentToPrefs(state);
  }

  // Method to update attendance
  void updateMarks(List<Map<String, dynamic>> marks) {
    state = state.copyWith(marks: marks);
    saveStudentToPrefs(state);
  }

  // Method to update notification settings
  void updateIsNotificationsEnabled(bool isNotificationsEnabled) {
    state = state.copyWith(isNotificationsEnabled: isNotificationsEnabled);
    saveStudentToPrefs(state);
  }

  // Method to update privacy mode
  void updateIsPrivacyModeEnabled(bool isPrivacyModeEnabled) {
    state = state.copyWith(isPrivacyModeEnabled: isPrivacyModeEnabled);
    saveStudentToPrefs(state);
  }

  // Method to update notification delay
  void updateNotificationDelay(int notificationDelay) {
    state = state.copyWith(notificationDelay: notificationDelay);
    saveStudentToPrefs(state);
  }

  // Load student data from Shared Preferences
  Future<void> loadStudent() async {
    final savedStudent = await loadStudentFromPrefs();

    if (savedStudent != null) {
      state = savedStudent;
      log("Saved Student after getting local data: ${state}");
    }
  }

  Future<void> loadLocalAttendance() async {
    attendanceState = const AsyncValue.loading(); // Set to loading state

    // Directly check the attendance in the current state
    if (state.attendance.isNotEmpty) {
      attendanceState = AsyncValue.data(state.attendance); // Wrap in AsyncValue
    } else {
      // If attendance is empty, you might want to load it first from preferences
      final savedStudent =
          await loadStudentFromPrefs(); // Load data if not already loaded
      if (savedStudent != null && savedStudent.attendance.isNotEmpty) {
        // Update state with loaded attendance
        state = savedStudent;
        attendanceState =
            AsyncValue.data(savedStudent.attendance); // Set data state
      } else {
        log("Attendance is empty: ${state.attendance.toString()}");
        attendanceState = AsyncValue.error(
            'No attendance data available locally', StackTrace.current);
      }
    }
  }

  Future<void> loadLocalTimetable() async {
    timetableState = const AsyncValue.loading(); // Set to loading state

    // Directly check the timetable in the current state
    if (state.timetable.isNotEmpty) {
      timetableState = AsyncValue.data(state.timetable); // Wrap in AsyncValue
    } else {
      // If timetable is empty, you might want to load it first from preferences
      final savedStudent =
          await loadStudentFromPrefs(); // Load data if not already loaded
      if (savedStudent != null && savedStudent.timetable.isNotEmpty) {
        // Update state with loaded timetable
        state = savedStudent;
        timetableState =
            AsyncValue.data(savedStudent.timetable); // Set data state
      } else {
        log("Timetable is empty: ${state.timetable.toString()}");
        timetableState = AsyncValue.error(
            'No timetable data available locally', StackTrace.current);
      }
    }
  }

  Future<void> loadLocalMarks() async {
    marksState = const AsyncValue.loading(); // Set to loading state

    // Directly check the marks in the current state
    if (state.marks.isNotEmpty) {
      marksState = AsyncValue.data(state.marks); // Wrap in AsyncValue
    } else {
      // If marks is empty, you might want to load it first from preferences
      final savedStudent =
          await loadStudentFromPrefs(); // Load data if not already loaded
      if (savedStudent != null && savedStudent.marks.isNotEmpty) {
        // Update state with loaded marks
        state = savedStudent;
        marksState = AsyncValue.data(savedStudent.marks); // Set data state
      } else {
        log("Marks is empty: ${state.marks.toString()}");
        marksState = AsyncValue.error(
            'No marks data available locally', StackTrace.current);
      }
    }
  }

  // Reset student state to default
  void resetStudent() {
    state = Student(
      name: '',
      regNo: '',
      profileImagePath: '',
      timetable: {},
      examSchedule: {},
      attendance: {},
      marks: [],
      isNotificationsEnabled: false,
      isPrivacyModeEnabled: false,
      notificationDelay: 0,
      profile: {},
    );
    saveStudentToPrefs(state);
  }
}

// Provider for accessing the StudentNotifier
final studentProvider = StateNotifierProvider<StudentNotifier, Student>((ref) {
  return StudentNotifier();
});
