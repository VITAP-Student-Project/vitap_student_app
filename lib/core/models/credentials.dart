// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@JsonSerializable()
class Credentials {
  final String registrationNumber;
  final String password;
  final String semSubId;
  final String? hostelWifiUsername;
  final String? hostelWifiPassword;
  final String? universityWifiUsername;
  final String? universityWifiPassword;

  Credentials({
    required this.registrationNumber,
    required this.password,
    required this.semSubId,
    this.hostelWifiUsername,
    this.hostelWifiPassword,
    this.universityWifiUsername,
    this.universityWifiPassword,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);

  Credentials copyWith({
    String? registrationNumber,
    String? password,
    String? semSubId,
    String? hostelWifiUsername,
    String? hostelWifiPassword,
    String? universityWifiUsername,
    String? universityWifiPassword,
  }) {
    return Credentials(
      registrationNumber: registrationNumber ?? this.registrationNumber,
      password: password ?? this.password,
      semSubId: semSubId ?? this.semSubId,
      hostelWifiUsername: hostelWifiUsername ?? this.hostelWifiUsername,
      hostelWifiPassword: hostelWifiPassword ?? this.hostelWifiPassword,
      universityWifiUsername:
          universityWifiUsername ?? this.universityWifiUsername,
      universityWifiPassword:
          universityWifiPassword ?? this.universityWifiPassword,
    );
  }

  @override
  String toString() {
    return 'Credentials(registrationNumber: $registrationNumber, password: $password, semSubId: $semSubId, hostelWifiUsername: $hostelWifiUsername, hostelWifiPassword: $hostelWifiPassword, universityWifiUsername: $universityWifiUsername, universityWifiPassword: $universityWifiPassword)';
  }
}
