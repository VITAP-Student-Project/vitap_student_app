// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentProfile {
  String get applicationNumber;
  String get studentName;
  String get dob;
  String get gender;
  String get bloodGroup;
  String get email;
  String get base64Pfp;
  GradeHistory get gradeHistory;
  MentorDetails get mentorDetails;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StudentProfileCopyWith<StudentProfile> get copyWith =>
      _$StudentProfileCopyWithImpl<StudentProfile>(
          this as StudentProfile, _$identity);

  /// Serializes this StudentProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StudentProfile &&
            (identical(other.applicationNumber, applicationNumber) ||
                other.applicationNumber == applicationNumber) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.base64Pfp, base64Pfp) ||
                other.base64Pfp == base64Pfp) &&
            (identical(other.gradeHistory, gradeHistory) ||
                other.gradeHistory == gradeHistory) &&
            (identical(other.mentorDetails, mentorDetails) ||
                other.mentorDetails == mentorDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, applicationNumber, studentName,
      dob, gender, bloodGroup, email, base64Pfp, gradeHistory, mentorDetails);

  @override
  String toString() {
    return 'StudentProfile(applicationNumber: $applicationNumber, studentName: $studentName, dob: $dob, gender: $gender, bloodGroup: $bloodGroup, email: $email, base64Pfp: $base64Pfp, gradeHistory: $gradeHistory, mentorDetails: $mentorDetails)';
  }
}

/// @nodoc
abstract mixin class $StudentProfileCopyWith<$Res> {
  factory $StudentProfileCopyWith(
          StudentProfile value, $Res Function(StudentProfile) _then) =
      _$StudentProfileCopyWithImpl;
  @useResult
  $Res call(
      {String applicationNumber,
      String studentName,
      String dob,
      String gender,
      String bloodGroup,
      String email,
      String base64Pfp,
      GradeHistory gradeHistory,
      MentorDetails mentorDetails});

  $GradeHistoryCopyWith<$Res> get gradeHistory;
  $MentorDetailsCopyWith<$Res> get mentorDetails;
}

/// @nodoc
class _$StudentProfileCopyWithImpl<$Res>
    implements $StudentProfileCopyWith<$Res> {
  _$StudentProfileCopyWithImpl(this._self, this._then);

  final StudentProfile _self;
  final $Res Function(StudentProfile) _then;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationNumber = null,
    Object? studentName = null,
    Object? dob = null,
    Object? gender = null,
    Object? bloodGroup = null,
    Object? email = null,
    Object? base64Pfp = null,
    Object? gradeHistory = null,
    Object? mentorDetails = null,
  }) {
    return _then(_self.copyWith(
      applicationNumber: null == applicationNumber
          ? _self.applicationNumber
          : applicationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _self.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      bloodGroup: null == bloodGroup
          ? _self.bloodGroup
          : bloodGroup // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      base64Pfp: null == base64Pfp
          ? _self.base64Pfp
          : base64Pfp // ignore: cast_nullable_to_non_nullable
              as String,
      gradeHistory: null == gradeHistory
          ? _self.gradeHistory
          : gradeHistory // ignore: cast_nullable_to_non_nullable
              as GradeHistory,
      mentorDetails: null == mentorDetails
          ? _self.mentorDetails
          : mentorDetails // ignore: cast_nullable_to_non_nullable
              as MentorDetails,
    ));
  }

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GradeHistoryCopyWith<$Res> get gradeHistory {
    return $GradeHistoryCopyWith<$Res>(_self.gradeHistory, (value) {
      return _then(_self.copyWith(gradeHistory: value));
    });
  }

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MentorDetailsCopyWith<$Res> get mentorDetails {
    return $MentorDetailsCopyWith<$Res>(_self.mentorDetails, (value) {
      return _then(_self.copyWith(mentorDetails: value));
    });
  }
}

/// Adds pattern-matching-related methods to [StudentProfile].
extension StudentProfilePatterns on StudentProfile {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_StudentProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudentProfile() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_StudentProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentProfile():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_StudentProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentProfile() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String applicationNumber,
            String studentName,
            String dob,
            String gender,
            String bloodGroup,
            String email,
            String base64Pfp,
            GradeHistory gradeHistory,
            MentorDetails mentorDetails)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudentProfile() when $default != null:
        return $default(
            _that.applicationNumber,
            _that.studentName,
            _that.dob,
            _that.gender,
            _that.bloodGroup,
            _that.email,
            _that.base64Pfp,
            _that.gradeHistory,
            _that.mentorDetails);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String applicationNumber,
            String studentName,
            String dob,
            String gender,
            String bloodGroup,
            String email,
            String base64Pfp,
            GradeHistory gradeHistory,
            MentorDetails mentorDetails)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentProfile():
        return $default(
            _that.applicationNumber,
            _that.studentName,
            _that.dob,
            _that.gender,
            _that.bloodGroup,
            _that.email,
            _that.base64Pfp,
            _that.gradeHistory,
            _that.mentorDetails);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String applicationNumber,
            String studentName,
            String dob,
            String gender,
            String bloodGroup,
            String email,
            String base64Pfp,
            GradeHistory gradeHistory,
            MentorDetails mentorDetails)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentProfile() when $default != null:
        return $default(
            _that.applicationNumber,
            _that.studentName,
            _that.dob,
            _that.gender,
            _that.bloodGroup,
            _that.email,
            _that.base64Pfp,
            _that.gradeHistory,
            _that.mentorDetails);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StudentProfile implements StudentProfile {
  const _StudentProfile(
      {required this.applicationNumber,
      required this.studentName,
      required this.dob,
      required this.gender,
      required this.bloodGroup,
      required this.email,
      required this.base64Pfp,
      required this.gradeHistory,
      required this.mentorDetails});
  factory _StudentProfile.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileFromJson(json);

  @override
  final String applicationNumber;
  @override
  final String studentName;
  @override
  final String dob;
  @override
  final String gender;
  @override
  final String bloodGroup;
  @override
  final String email;
  @override
  final String base64Pfp;
  @override
  final GradeHistory gradeHistory;
  @override
  final MentorDetails mentorDetails;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StudentProfileCopyWith<_StudentProfile> get copyWith =>
      __$StudentProfileCopyWithImpl<_StudentProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StudentProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StudentProfile &&
            (identical(other.applicationNumber, applicationNumber) ||
                other.applicationNumber == applicationNumber) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.base64Pfp, base64Pfp) ||
                other.base64Pfp == base64Pfp) &&
            (identical(other.gradeHistory, gradeHistory) ||
                other.gradeHistory == gradeHistory) &&
            (identical(other.mentorDetails, mentorDetails) ||
                other.mentorDetails == mentorDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, applicationNumber, studentName,
      dob, gender, bloodGroup, email, base64Pfp, gradeHistory, mentorDetails);

  @override
  String toString() {
    return 'StudentProfile(applicationNumber: $applicationNumber, studentName: $studentName, dob: $dob, gender: $gender, bloodGroup: $bloodGroup, email: $email, base64Pfp: $base64Pfp, gradeHistory: $gradeHistory, mentorDetails: $mentorDetails)';
  }
}

/// @nodoc
abstract mixin class _$StudentProfileCopyWith<$Res>
    implements $StudentProfileCopyWith<$Res> {
  factory _$StudentProfileCopyWith(
          _StudentProfile value, $Res Function(_StudentProfile) _then) =
      __$StudentProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String applicationNumber,
      String studentName,
      String dob,
      String gender,
      String bloodGroup,
      String email,
      String base64Pfp,
      GradeHistory gradeHistory,
      MentorDetails mentorDetails});

  @override
  $GradeHistoryCopyWith<$Res> get gradeHistory;
  @override
  $MentorDetailsCopyWith<$Res> get mentorDetails;
}

/// @nodoc
class __$StudentProfileCopyWithImpl<$Res>
    implements _$StudentProfileCopyWith<$Res> {
  __$StudentProfileCopyWithImpl(this._self, this._then);

  final _StudentProfile _self;
  final $Res Function(_StudentProfile) _then;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? applicationNumber = null,
    Object? studentName = null,
    Object? dob = null,
    Object? gender = null,
    Object? bloodGroup = null,
    Object? email = null,
    Object? base64Pfp = null,
    Object? gradeHistory = null,
    Object? mentorDetails = null,
  }) {
    return _then(_StudentProfile(
      applicationNumber: null == applicationNumber
          ? _self.applicationNumber
          : applicationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _self.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      bloodGroup: null == bloodGroup
          ? _self.bloodGroup
          : bloodGroup // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      base64Pfp: null == base64Pfp
          ? _self.base64Pfp
          : base64Pfp // ignore: cast_nullable_to_non_nullable
              as String,
      gradeHistory: null == gradeHistory
          ? _self.gradeHistory
          : gradeHistory // ignore: cast_nullable_to_non_nullable
              as GradeHistory,
      mentorDetails: null == mentorDetails
          ? _self.mentorDetails
          : mentorDetails // ignore: cast_nullable_to_non_nullable
              as MentorDetails,
    ));
  }

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GradeHistoryCopyWith<$Res> get gradeHistory {
    return $GradeHistoryCopyWith<$Res>(_self.gradeHistory, (value) {
      return _then(_self.copyWith(gradeHistory: value));
    });
  }

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MentorDetailsCopyWith<$Res> get mentorDetails {
    return $MentorDetailsCopyWith<$Res>(_self.mentorDetails, (value) {
      return _then(_self.copyWith(mentorDetails: value));
    });
  }
}

// dart format on
