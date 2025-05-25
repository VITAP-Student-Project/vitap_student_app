import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'credentials.g.dart';

@Entity()
@JsonSerializable()
class Credentials {
  @Id()
  int id = 0;

  @JsonKey(name: 'registration_number')
  final String registrationNumber;
  final String password;
  final String semSubId;

  Credentials({
    required this.registrationNumber,
    required this.password,
    required this.semSubId,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}
