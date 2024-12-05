import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../../models/user.dart';
import '../data/student_shared_preferences.dart';
import '../api/apis.dart';

// Notifier class that provides the logic for updating values
class StudentNotifier extends StateNotifier<AsyncValue<Student>> {
  StudentNotifier()
      : super(AsyncValue.data(Student(
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
        ))) {
    init(); // Load student from Shared Preferences initially
  }

  // Private async method to load student data
  Future<void> init() async {
    await loadStudent();
  }

  // Load student data from Shared Preferences
  Future<void> loadStudent() async {
    final savedStudent = await loadStudentFromPrefs();

    if (savedStudent != null) {
      state = AsyncValue.data(savedStudent);
      log("Saved Student after getting local data: ${state}");
    }
  }

  // Fetch and update profile with loading indicator
  Future<void> loginAndUpdateStudent(
      String username, String password, String semSubID) async {
    state = const AsyncValue.loading();

    try {
      final response = await fetchStudentData(username, password, semSubID);
      if (response.statusCode == 200) {
        final studentData = jsonDecode(response.body);

        // Create an updated student with the new profile data
        final updatedStudent = state.value?.copyWith(
              timetable: studentData['timetable'] ?? {},
              attendance: studentData['attendance'] ?? {},
              marks: (studentData['marks'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [],
              profile: studentData['profile'] ?? {},
              examSchedule: studentData['exam_schedule'] ?? {},
            ) ??
            Student(
              profileImagePath: '',
              timetable: studentData['timetable'] ?? {},
              examSchedule: studentData['exam_schedule'] ?? {},
              attendance: studentData['attendance'] ?? {},
              marks: (studentData['marks'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [],
              isNotificationsEnabled: false,
              isPrivacyModeEnabled: false,
              notificationDelay: 0,
              profile: studentData['profile'] ?? {},
              name: '',
              regNo: '',
            );

        // Update state with the new student data
        state = AsyncValue.data(updatedStudent);

        // Save the updated student to preferences

        updateLoginStatus(true);
        storeCredentials(username, semSubID, password);
        updateLocalStudent(updatedStudent);
      } else {
        state = AsyncValue.error(
          'Login failed: ${response.statusCode}',
          StackTrace.current,
        );
        log("Login failed: ${response.statusCode}");
      }
    } catch (e) {
      state = AsyncValue.error(
        'An error occurred during login: $e',
        StackTrace.current,
      );
      log("Login error: $e");
    }
  }

  Future refreshTimetable() async {
    try {
      // Safely extract the current student data
      final currentStudent = state.value ??
          Student(
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

      state = const AsyncValue.loading();
      final response = await fetchTimetable();
      if (response.statusCode == 200) {
        final timetableData = jsonDecode(response.body);

        final updatedStudent = currentStudent.copyWith(
          timetable: timetableData['timetable'],
        );

        // Wrap the updated student in AsyncValue.data
        state = AsyncValue.data(updatedStudent);
        updateLocalTimetable(timetableData['timetable']);
      } else {
        state = AsyncValue.error(
          'Failed to fetch timetable: ${response.statusCode}',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(
        'An error occurred: $e',
        StackTrace.current,
      );
    }
  }

  // Fetch and update attendance with loading indicator
  Future<void> refreshAttendance() async {
    // Set to loading state

    // Safely extract the current student data
    final currentStudent = state.value ??
        Student(
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

    try {
      state = const AsyncValue.loading();
      final response = await fetchAttendanceData();
      if (response.statusCode == 200) {
        final attendanceData = jsonDecode(response.body);

        final updatedStudent = currentStudent.copyWith(
          attendance: attendanceData['attendance'],
        );
        state = AsyncValue.data(updatedStudent);
        updateLocalAttendance(attendanceData['attendance']);
      } else {
        state = jsonDecode(response.body);
        log("${AsyncValue.error('Failed to fetch attendance: ${response.statusCode}', StackTrace.current)}");
      }
    } catch (e) {
      log("Error : $e , Stack : ${StackTrace.current}");
      state = AsyncValue.error('An error occurred: $e', StackTrace.current);
    }
  }

// Fetch and update marks with loading indicator
  Future<void> refreshMarks() async {
    log("Current student data: ${state.value}");
    try {
      // Safely extract the current student data
      final currentStudent = state.value ??
          Student(
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
      state = const AsyncValue.loading();
      final response = await fetchMarks();
      if (response.statusCode == 200) {
        final marksData = jsonDecode(response.body);
        log("Marks raw data: $marksData");

        // Cast marksData['marks'] to List<Map<String, dynamic>>
        List<Map<String, dynamic>> marksList =
            List<Map<String, dynamic>>.from(marksData['marks']);

        final updatedStudent = currentStudent.copyWith(
          marks: marksList,
        );

        state = AsyncValue.data(updatedStudent);
        updateLocalMarks(marksList);
      } else {
        state = AsyncValue.error(
          'Failed to fetch marks: ${response.statusCode}',
          StackTrace.current,
        );
        log("Failed to fetch marks: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e StackTrace ${StackTrace.current}");
      state = AsyncValue.error(
        'An error occurred: $e',
        StackTrace.current,
      );
    }
  }

  Future<void> refreshExamSchedule() async {
    final currentStudent = state.value ??
        Student(
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

    try {
      state = const AsyncValue.loading();
      final response = await fetchExamSchedule();
      if (response.statusCode == 200) {
        final examScheduleData = jsonDecode(response.body);

        final updatedStudent = currentStudent.copyWith(
          examSchedule: examScheduleData['exam_schedule'],
        );
        state = AsyncValue.data(updatedStudent);
        updateLocalAttendance(examScheduleData['exam_schedule']);
      } else {
        state = jsonDecode(response.body);
        log("${AsyncValue.error('Failed to fetch attendance: ${response.statusCode}', StackTrace.current)}");
      }
    } catch (e) {
      log("Error : $e , Stack : ${StackTrace.current}");
      state = AsyncValue.error('An error occurred: $e', StackTrace.current);
    }
  }

// Fetch and display marks biometric info for a particular date loading indicator
  Future<void> fetchAndDisplayBiometric(String date) async {
    state = const AsyncValue.loading(); // Set to loading state

    try {
      // Safely extract the current student data
      final currentStudent = state.value ??
          Student(
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

      final response = await fetchBiometricLog(date);
      if (response.statusCode == 200) {
        final biometricData = jsonDecode(response.body);
        log("Biometric raw data: $biometricData");

        Map<String, dynamic> biometricLog =
            Map<String, dynamic>.from(biometricData);

        // Update state with the new biometric log
        state = AsyncValue.data(currentStudent.copyWith(
          profile: {...currentStudent.profile, 'biometricLog': biometricLog},
        ));
      } else {
        state = AsyncValue.error(
          'Failed to fetch biometrics: ${response.statusCode}',
          StackTrace.current,
        );
        log("Failed to fetch biometrics: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e StackTrace ${StackTrace.current}");
      state = AsyncValue.error(
        'An error occurred: $e',
        StackTrace.current,
      );
    }
  }

  // Method to update local student data
  void updateLocalStudent(Student student) {
    saveStudentToPrefs(student);
  }

  // Method to update timetable
  void updateLocalTimetable(Map<String, dynamic> timetable) {
    saveStudentToPrefs(state.value!);
  }

  // Method to update attendance
  void updateLocalAttendance(Map<String, dynamic> attendance) {
    saveStudentToPrefs(state.value!);
  }

  // Method to update attendance
  void updateLocalMarks(List<Map<String, dynamic>> marks) {
    saveStudentToPrefs(state.value!);
  }

  // Method to update notification settings
  void updateIsNotificationsEnabled(bool isNotificationsEnabled) {
    saveStudentToPrefs(state.value!);
  }

  // Method to update notification settings
  void updateLocalLoginStatus(bool isLoggedIn) {
    updateLoginStatus(isLoggedIn);
  }

  // Method to update privacy mode
  void updateIsPrivacyModeEnabled(bool isPrivacyModeEnabled) {
    saveStudentToPrefs(state.value!);
  }

  // Method to update notification delay
  void updateNotificationDelay(int notificationDelay) {
    saveStudentToPrefs(state.value!);
  }

  // Reset student state to default
  void resetStudent() {
    final Student emptyStudent = Student(
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
    state = AsyncValue.data(emptyStudent);
    saveStudentToPrefs(emptyStudent);
  }
}

// Provider for accessing the StudentNotifier
final studentProvider =
    StateNotifierProvider<StudentNotifier, AsyncValue<Student>>((ref) {
  return StudentNotifier();
});
