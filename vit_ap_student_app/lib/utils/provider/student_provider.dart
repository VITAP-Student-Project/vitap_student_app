import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../data/student_shared_preferences.dart';
import '../api/apis.dart';
import '../exceptions/MissingCredentialException.dart';
import '../helper/safe_parsers.dart';
import '../model/attendance_model.dart';
import '../model/exam_schedule_model.dart';
import '../model/marks_model.dart';
import '../model/profile_model.dart';
import '../model/student_model.dart';
import '../model/timetable_model.dart';

// Notifier class that provides the logic for updating values
class StudentNotifier extends StateNotifier<AsyncValue<Student>> {
  StudentNotifier()
      : super(
          AsyncValue.data(
            Student.empty(),
          ),
        ) {
    init();
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

  Future<bool> studentLogin(
    String username,
    String password,
    String semSubID,
    WidgetRef ref,
  ) async {
    final currentStudent = state.value ?? Student.empty();
    state = const AsyncValue.loading();

    try {
      // Fetch data from the API
      final response = await fetchStudentData(
        username,
        password,
        semSubID,
        ref,
      );

      if (response.statusCode == 200) {
        // Decode JSON response
        final studentData = jsonDecode(response.body);

        final parsedStudent = currentStudent.copyWith(
          registrationNumber: username,
          semSubId: semSubID,
          isLoggedIn: true,
          attendance: safeParseAttendance(studentData['attendance']),
          examSchedule: safeParseExamSchedule(studentData['exam_schedule']),
          marks: safeParseMarks(studentData['marks']),
          profile: safeParseProfile(studentData['profile']),
          timetable: safeParseTimetable(studentData['timetable']),
        );
        parsedStudent.setPassword(password);
        state = AsyncValue.data(parsedStudent);

        updateLocalStudent(parsedStudent);

        log("Parsed and updated Student: ${parsedStudent.toJson()}");
        return true; // Return true on successful login
      } else {
        // Handle non-200 responses
        state = AsyncValue.error(
          'Login failed: ${response.statusCode}',
          StackTrace.current,
        );
        log("Login failed: ${response.statusCode}");
        return false; // Return false on login failure
      }
    } catch (e, stackTrace) {
      // Handle errors during API call or JSON parsing
      state = AsyncValue.error(
        'An error occurred during login: $e',
        stackTrace,
      );
      log("Login error: $e");
      return false; // Return false on error
    }
  }

  Future<void> refreshTimetable(WidgetRef ref) async {
    final currentStudent = state.value ?? Student.empty();
    try {
      final response = await fetchTimetable(ref);

      if (response.statusCode == 200) {
        final timetableData = jsonDecode(response.body);
        final updatedTimetable = Timetable.fromJson(timetableData['timetable']);

        final updatedStudent =
            currentStudent.copyWith(timetable: updatedTimetable);
        state = AsyncValue.data(updatedStudent);
        updateLocalStudent(updatedStudent);
      } else {
        final errorTimetable = Timetable.error(
            'Failed to fetch timetable: ${response.statusCode}');
        final updatedStudent =
            currentStudent.copyWith(timetable: errorTimetable);
        state = AsyncValue.data(updatedStudent);
      }
    } catch (e, stackTrace) {
      final errorTimetable =
          Timetable.error('An error occurred: $e $stackTrace');
      final updatedStudent = currentStudent.copyWith(timetable: errorTimetable);
      state = AsyncValue.data(updatedStudent);
    }
  }

  // Fetch and update attendance with loading indicator
  Future<void> refreshAttendance(WidgetRef ref) async {
    final currentStudent = state.value ?? Student.empty();
    try {
      final response = await fetchAttendanceData(ref);

      if (response.statusCode == 200) {
        final attendanceData = jsonDecode(response.body);
        final updatedAttendance = Map<String, Attendance>.from(
          attendanceData['attendance'].map(
            (k, v) => MapEntry(k, Attendance.fromJson(v)),
          ),
        );

        final updatedStudent = currentStudent.copyWith(
          attendance: updatedAttendance,
        );

        state = AsyncValue.data(updatedStudent);
        updateLocalStudent(updatedStudent);
      } else {
        final errorAttendance = Attendance.error(
            'Failed to fetch attendance: ${response.statusCode}');
        final updatedStudent =
            currentStudent.copyWith(attendance: {"error": errorAttendance});
        state = AsyncValue.data(updatedStudent);
      }
    } catch (e, stackTrace) {
      final errorAttendance =
          Attendance.error('An error occurred: $e $stackTrace');
      final updatedStudent =
          currentStudent.copyWith(attendance: {"error": errorAttendance});
      state = AsyncValue.data(updatedStudent);
    }
  }

// Fetch and update marks with loading indicator
  Future<void> refreshMarks(WidgetRef ref) async {
    final currentStudent = state.value ?? Student.empty();
    try {
      final response = await fetchMarks(ref);

      if (response.statusCode == 200) {
        final marksData = jsonDecode(response.body);
        final updatedMarks = List<Mark>.from(
          marksData['marks'].map((x) => Mark.fromJson(x)),
        );

        final updatedStudent = currentStudent.copyWith(
          marks: updatedMarks,
        );

        state = AsyncValue.data(updatedStudent);
        updateLocalStudent(updatedStudent);
      } else {
        final errorMark =
            Mark.error('Failed to fetch timetable: ${response.statusCode}');
        final updatedStudent = currentStudent.copyWith(marks: [errorMark]);
        state = AsyncValue.data(updatedStudent);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('An error occurred: $e', stackTrace);
    }
  }

  Future<void> refreshExamSchedule(WidgetRef ref) async {
    try {
      final currentStudent = state.value ?? Student.empty();

      final response = await fetchExamSchedule(ref);

      if (response.statusCode == 200) {
        final examScheduleData = jsonDecode(response.body);
        final updatedExamSchedule = List<ExamSchedule>.from(
          examScheduleData['exam_schedule']
              .map((x) => ExamSchedule.fromJson(x)),
        );

        final updatedStudent = currentStudent.copyWith(
          examSchedule: updatedExamSchedule,
        );

        state = AsyncValue.data(updatedStudent);
        updateLocalStudent(updatedStudent);
      } else {
        state = AsyncValue.error(
          'Failed to fetch exam schedule: ${response.statusCode}',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('An error occurred: $e', stackTrace);
    }
  }

  // Fetch and update profile with loading indicator
  Future<void> syncStudentData(WidgetRef ref) async {
    final currentStudent = state.value ?? Student.empty();
    final username = currentStudent.registrationNumber;
    final password = await currentStudent.password;
    final semSubId = currentStudent.semSubId;

    try {
      // Fetch data from the API
      final response = await fetchStudentData(
          currentStudent.registrationNumber, password!, semSubId, ref);

      if (response.statusCode == 200) {
        final studentData = jsonDecode(response.body);

        final latestStudent = currentStudent.copyWith(
          registrationNumber: username,
          semSubId: semSubId,
          isLoggedIn: true,
          attendance: Map.from(studentData['attendance']).map(
            (k, v) => MapEntry<String, Attendance>(k, Attendance.fromJson(v)),
          ),
          examSchedule: List<ExamSchedule>.from(
            studentData['exam_schedule'].map((x) => ExamSchedule.fromJson(x)),
          ),
          marks: List<Mark>.from(
            studentData['marks'].map((x) => Mark.fromJson(x)),
          ),
          profile: Profile.fromJson(studentData['profile']),
          timetable: Timetable.fromJson(studentData['timetable']),
        );
        latestStudent.setPassword(password);
        state = AsyncValue.data(latestStudent);

        updateLocalStudent(latestStudent);
        log("Parsed and updated Student: ${latestStudent.toJson()}");
      } else {
        // Handle non-200 responses
        state = AsyncValue.error(
          'Login failed: ${response.statusCode}',
          StackTrace.current,
        );
        log("Login failed: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      // Handle errors during API call or JSON parsing
      state = AsyncValue.error(
        'An error occurred during login: $e',
        stackTrace,
      );
      log("Login error: $e");
    }
  }

  // Fetch and update profile with loading indicator
  Future<void> changeStudentSemester(String newSemSubId, WidgetRef ref) async {
    final currentStudent = state.value ?? Student.empty();
    final username = currentStudent.registrationNumber;
    final password = await currentStudent.password;

    try {
      // Fetch data from the API
      final response = await fetchStudentData(
          currentStudent.registrationNumber, password!, newSemSubId, ref);

      if (response.statusCode == 200) {
        final studentData = jsonDecode(response.body);

        final latestStudent = Student(
          registrationNumber: username,
          semSubId: newSemSubId,
          pfpPath: "",
          isLoggedIn: true,
          attendance: Map.from(studentData['attendance']).map(
            (k, v) => MapEntry<String, Attendance>(k, Attendance.fromJson(v)),
          ),
          examSchedule: List<ExamSchedule>.from(
            studentData['exam_schedule'].map((x) => ExamSchedule.fromJson(x)),
          ),
          marks: List<Mark>.from(
            studentData['marks'].map((x) => Mark.fromJson(x)),
          ),
          profile: Profile.fromJson(studentData['profile']),
          timetable: Timetable.fromJson(studentData['timetable']),
        );
        latestStudent.setPassword(password);
        state = AsyncValue.data(latestStudent);
        updateLocalStudent(latestStudent);
        log("Parsed and updated Student: ${latestStudent.toJson()}");
      } else {
        // Handle non-200 responses
        state = AsyncValue.error(
          'Login failed: ${response.statusCode}',
          StackTrace.current,
        );
        log("Login failed: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      // Handle errors during API call or JSON parsing
      state = AsyncValue.error(
        'An error occurred during login: $e',
        stackTrace,
      );
      log("Login error: $e");
    }
  }

  Future<Map<String, String>> getCredentials() async {
    final currentStudent = state.value ?? Student.empty();
    log("Current Student: ${state.value}");

    final password = await currentStudent.password;

    if (currentStudent.registrationNumber.isEmpty) {
      throw MissingCredentialsException(
          "Registration number is missing or empty.");
    }

    if (currentStudent.semSubId.isEmpty) {
      throw MissingCredentialsException(
          "Semester Subject ID is missing or empty.");
    }

    if (password == null || password.isEmpty) {
      throw MissingCredentialsException("Password is missing or empty.");
    }

    state = const AsyncValue.loading();

    return {
      'username': currentStudent.registrationNumber,
      'password': password,
      'semSubID': currentStudent.semSubId,
    };
  }

  // Method to update local student data
  void updateLocalStudent(Student student) {
    saveStudentToPrefs(student);
  }

  // Method to update local student data
  void updateProfilePic(String pfpPath) {
    final currentStudent = state.value ?? Student.empty();
    Student updatedStudent = currentStudent.copyWith(pfpPath: pfpPath);
    state = AsyncValue.data(updatedStudent);
    saveStudentToPrefs(updatedStudent);
  }

  // Reset student state to default
  void resetStudent() {
    final Student emptyStudent = Student.empty();
    state = AsyncValue.data(emptyStudent);
    saveStudentToPrefs(emptyStudent);
  }
}

// Provider for accessing the StudentNotifier
final studentProvider =
    StateNotifierProvider<StudentNotifier, AsyncValue<Student>>((ref) {
  return StudentNotifier();
});
