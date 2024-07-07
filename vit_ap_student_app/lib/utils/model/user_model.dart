class User {
  final String userName;
  final String userPassword;
  final String userProfilePicPath;
  final String userTimetable;

  User({
    required this.userName,
    required this.userPassword,
    required this.userProfilePicPath,
    required this.userTimetable,
  });

  User copyWith({
    String? userName,
    String? userPassword,
    String? userProfilePicPath,
    String? userTimetable,
  }) {
    return User(
      userName: userName ?? this.userName,
      userPassword: userPassword ?? this.userPassword,
      userProfilePicPath: userProfilePicPath ?? this.userProfilePicPath,
      userTimetable: userTimetable ?? this.userTimetable,
    );
  }
}
