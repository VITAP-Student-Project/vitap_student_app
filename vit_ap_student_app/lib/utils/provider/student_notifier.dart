import 'student_provider.dart';

class StudentController {
  final StudentNotifier studentNotifier;

  StudentController(this.studentNotifier);

  // void updateName(String newName) {
  //   studentNotifier.updateName(newName);
  // }

  // void updateProfileImage(String newPath) {
  //   studentNotifier.updateProfileImagePath(newPath);
  // }

  // void updateRegNo(String newRegNo) {
  //   studentNotifier.updateRegNo(newRegNo);
  // }

  // Fetch and update timetable via API
  Future<void> fetchTimetable() async {
    await studentNotifier.fetchAndUpdateTimetable();
  }

  // Fetch and update attendance via API
  Future<void> fetchAttendance() async {
    await studentNotifier.fetchAndUpdateAttendance();
  }

  // Fetch and update attendance via API
  Future<void> fetchMarks() async {
    await studentNotifier.fetchAndUpdateMarks();
  }

  // Perform login and update profile
  Future<void> login(String username, String password, String semSubID) async {
    await studentNotifier.loginAndUpdateProfile(username, password, semSubID);
  }

  // Method to update privacy mode
  void updateIsPrivacyModeEnabled(bool isPrivacyModeEnabled) {
    studentNotifier.updateIsPrivacyModeEnabled(isPrivacyModeEnabled);
  }

  // Method to update notification preferences
  void updateIsNotificationsEnabled(bool isNotificationsEnabled) {
    studentNotifier.updateIsNotificationsEnabled(isNotificationsEnabled);
  }

  // Method to update notification delay
  void updateNotificationDelay(int notificationDelay) {
    studentNotifier.updateNotificationDelay(notificationDelay);
  }

  // Other methods like resetStudent, updateTimetable, etc.
  void resetStudent() {
    studentNotifier.resetStudent();
  }
}
