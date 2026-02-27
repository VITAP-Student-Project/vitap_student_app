// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssignmentRecordEach {
  String get serialNumber;
  String get assignmentTitle;
  String get maxAssignmentMark;
  String get assignmentWeightageMark;
  String get dueDate;
  bool get canQpDownload;
  String get qpDownloadUrl;
  String get submissionStatus;
  bool get canUpdate;
  String get mcode;
  bool get canDaDownload;
  String get daDownloadUrl;

  /// Create a copy of AssignmentRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssignmentRecordEachCopyWith<AssignmentRecordEach> get copyWith =>
      _$AssignmentRecordEachCopyWithImpl<AssignmentRecordEach>(
          this as AssignmentRecordEach, _$identity);

  /// Serializes this AssignmentRecordEach to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssignmentRecordEach &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.assignmentTitle, assignmentTitle) ||
                other.assignmentTitle == assignmentTitle) &&
            (identical(other.maxAssignmentMark, maxAssignmentMark) ||
                other.maxAssignmentMark == maxAssignmentMark) &&
            (identical(
                    other.assignmentWeightageMark, assignmentWeightageMark) ||
                other.assignmentWeightageMark == assignmentWeightageMark) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.canQpDownload, canQpDownload) ||
                other.canQpDownload == canQpDownload) &&
            (identical(other.qpDownloadUrl, qpDownloadUrl) ||
                other.qpDownloadUrl == qpDownloadUrl) &&
            (identical(other.submissionStatus, submissionStatus) ||
                other.submissionStatus == submissionStatus) &&
            (identical(other.canUpdate, canUpdate) ||
                other.canUpdate == canUpdate) &&
            (identical(other.mcode, mcode) || other.mcode == mcode) &&
            (identical(other.canDaDownload, canDaDownload) ||
                other.canDaDownload == canDaDownload) &&
            (identical(other.daDownloadUrl, daDownloadUrl) ||
                other.daDownloadUrl == daDownloadUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      assignmentTitle,
      maxAssignmentMark,
      assignmentWeightageMark,
      dueDate,
      canQpDownload,
      qpDownloadUrl,
      submissionStatus,
      canUpdate,
      mcode,
      canDaDownload,
      daDownloadUrl);

  @override
  String toString() {
    return 'AssignmentRecordEach(serialNumber: $serialNumber, assignmentTitle: $assignmentTitle, maxAssignmentMark: $maxAssignmentMark, assignmentWeightageMark: $assignmentWeightageMark, dueDate: $dueDate, canQpDownload: $canQpDownload, qpDownloadUrl: $qpDownloadUrl, submissionStatus: $submissionStatus, canUpdate: $canUpdate, mcode: $mcode, canDaDownload: $canDaDownload, daDownloadUrl: $daDownloadUrl)';
  }
}

/// @nodoc
abstract mixin class $AssignmentRecordEachCopyWith<$Res> {
  factory $AssignmentRecordEachCopyWith(AssignmentRecordEach value,
          $Res Function(AssignmentRecordEach) _then) =
      _$AssignmentRecordEachCopyWithImpl;
  @useResult
  $Res call(
      {String serialNumber,
      String assignmentTitle,
      String maxAssignmentMark,
      String assignmentWeightageMark,
      String dueDate,
      bool canQpDownload,
      String qpDownloadUrl,
      String submissionStatus,
      bool canUpdate,
      String mcode,
      bool canDaDownload,
      String daDownloadUrl});
}

/// @nodoc
class _$AssignmentRecordEachCopyWithImpl<$Res>
    implements $AssignmentRecordEachCopyWith<$Res> {
  _$AssignmentRecordEachCopyWithImpl(this._self, this._then);

  final AssignmentRecordEach _self;
  final $Res Function(AssignmentRecordEach) _then;

  /// Create a copy of AssignmentRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serialNumber = null,
    Object? assignmentTitle = null,
    Object? maxAssignmentMark = null,
    Object? assignmentWeightageMark = null,
    Object? dueDate = null,
    Object? canQpDownload = null,
    Object? qpDownloadUrl = null,
    Object? submissionStatus = null,
    Object? canUpdate = null,
    Object? mcode = null,
    Object? canDaDownload = null,
    Object? daDownloadUrl = null,
  }) {
    return _then(_self.copyWith(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentTitle: null == assignmentTitle
          ? _self.assignmentTitle
          : assignmentTitle // ignore: cast_nullable_to_non_nullable
              as String,
      maxAssignmentMark: null == maxAssignmentMark
          ? _self.maxAssignmentMark
          : maxAssignmentMark // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentWeightageMark: null == assignmentWeightageMark
          ? _self.assignmentWeightageMark
          : assignmentWeightageMark // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      canQpDownload: null == canQpDownload
          ? _self.canQpDownload
          : canQpDownload // ignore: cast_nullable_to_non_nullable
              as bool,
      qpDownloadUrl: null == qpDownloadUrl
          ? _self.qpDownloadUrl
          : qpDownloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      submissionStatus: null == submissionStatus
          ? _self.submissionStatus
          : submissionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      canUpdate: null == canUpdate
          ? _self.canUpdate
          : canUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      mcode: null == mcode
          ? _self.mcode
          : mcode // ignore: cast_nullable_to_non_nullable
              as String,
      canDaDownload: null == canDaDownload
          ? _self.canDaDownload
          : canDaDownload // ignore: cast_nullable_to_non_nullable
              as bool,
      daDownloadUrl: null == daDownloadUrl
          ? _self.daDownloadUrl
          : daDownloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AssignmentRecordEach].
extension AssignmentRecordEachPatterns on AssignmentRecordEach {
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
    TResult Function(_AssignmentRecordEach value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssignmentRecordEach() when $default != null:
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
    TResult Function(_AssignmentRecordEach value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentRecordEach():
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
    TResult? Function(_AssignmentRecordEach value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentRecordEach() when $default != null:
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
            String serialNumber,
            String assignmentTitle,
            String maxAssignmentMark,
            String assignmentWeightageMark,
            String dueDate,
            bool canQpDownload,
            String qpDownloadUrl,
            String submissionStatus,
            bool canUpdate,
            String mcode,
            bool canDaDownload,
            String daDownloadUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssignmentRecordEach() when $default != null:
        return $default(
            _that.serialNumber,
            _that.assignmentTitle,
            _that.maxAssignmentMark,
            _that.assignmentWeightageMark,
            _that.dueDate,
            _that.canQpDownload,
            _that.qpDownloadUrl,
            _that.submissionStatus,
            _that.canUpdate,
            _that.mcode,
            _that.canDaDownload,
            _that.daDownloadUrl);
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
            String serialNumber,
            String assignmentTitle,
            String maxAssignmentMark,
            String assignmentWeightageMark,
            String dueDate,
            bool canQpDownload,
            String qpDownloadUrl,
            String submissionStatus,
            bool canUpdate,
            String mcode,
            bool canDaDownload,
            String daDownloadUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentRecordEach():
        return $default(
            _that.serialNumber,
            _that.assignmentTitle,
            _that.maxAssignmentMark,
            _that.assignmentWeightageMark,
            _that.dueDate,
            _that.canQpDownload,
            _that.qpDownloadUrl,
            _that.submissionStatus,
            _that.canUpdate,
            _that.mcode,
            _that.canDaDownload,
            _that.daDownloadUrl);
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
            String serialNumber,
            String assignmentTitle,
            String maxAssignmentMark,
            String assignmentWeightageMark,
            String dueDate,
            bool canQpDownload,
            String qpDownloadUrl,
            String submissionStatus,
            bool canUpdate,
            String mcode,
            bool canDaDownload,
            String daDownloadUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentRecordEach() when $default != null:
        return $default(
            _that.serialNumber,
            _that.assignmentTitle,
            _that.maxAssignmentMark,
            _that.assignmentWeightageMark,
            _that.dueDate,
            _that.canQpDownload,
            _that.qpDownloadUrl,
            _that.submissionStatus,
            _that.canUpdate,
            _that.mcode,
            _that.canDaDownload,
            _that.daDownloadUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AssignmentRecordEach implements AssignmentRecordEach {
  const _AssignmentRecordEach(
      {required this.serialNumber,
      required this.assignmentTitle,
      required this.maxAssignmentMark,
      required this.assignmentWeightageMark,
      required this.dueDate,
      required this.canQpDownload,
      required this.qpDownloadUrl,
      required this.submissionStatus,
      required this.canUpdate,
      required this.mcode,
      required this.canDaDownload,
      required this.daDownloadUrl});
  factory _AssignmentRecordEach.fromJson(Map<String, dynamic> json) =>
      _$AssignmentRecordEachFromJson(json);

  @override
  final String serialNumber;
  @override
  final String assignmentTitle;
  @override
  final String maxAssignmentMark;
  @override
  final String assignmentWeightageMark;
  @override
  final String dueDate;
  @override
  final bool canQpDownload;
  @override
  final String qpDownloadUrl;
  @override
  final String submissionStatus;
  @override
  final bool canUpdate;
  @override
  final String mcode;
  @override
  final bool canDaDownload;
  @override
  final String daDownloadUrl;

  /// Create a copy of AssignmentRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssignmentRecordEachCopyWith<_AssignmentRecordEach> get copyWith =>
      __$AssignmentRecordEachCopyWithImpl<_AssignmentRecordEach>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AssignmentRecordEachToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssignmentRecordEach &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.assignmentTitle, assignmentTitle) ||
                other.assignmentTitle == assignmentTitle) &&
            (identical(other.maxAssignmentMark, maxAssignmentMark) ||
                other.maxAssignmentMark == maxAssignmentMark) &&
            (identical(
                    other.assignmentWeightageMark, assignmentWeightageMark) ||
                other.assignmentWeightageMark == assignmentWeightageMark) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.canQpDownload, canQpDownload) ||
                other.canQpDownload == canQpDownload) &&
            (identical(other.qpDownloadUrl, qpDownloadUrl) ||
                other.qpDownloadUrl == qpDownloadUrl) &&
            (identical(other.submissionStatus, submissionStatus) ||
                other.submissionStatus == submissionStatus) &&
            (identical(other.canUpdate, canUpdate) ||
                other.canUpdate == canUpdate) &&
            (identical(other.mcode, mcode) || other.mcode == mcode) &&
            (identical(other.canDaDownload, canDaDownload) ||
                other.canDaDownload == canDaDownload) &&
            (identical(other.daDownloadUrl, daDownloadUrl) ||
                other.daDownloadUrl == daDownloadUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      assignmentTitle,
      maxAssignmentMark,
      assignmentWeightageMark,
      dueDate,
      canQpDownload,
      qpDownloadUrl,
      submissionStatus,
      canUpdate,
      mcode,
      canDaDownload,
      daDownloadUrl);

  @override
  String toString() {
    return 'AssignmentRecordEach(serialNumber: $serialNumber, assignmentTitle: $assignmentTitle, maxAssignmentMark: $maxAssignmentMark, assignmentWeightageMark: $assignmentWeightageMark, dueDate: $dueDate, canQpDownload: $canQpDownload, qpDownloadUrl: $qpDownloadUrl, submissionStatus: $submissionStatus, canUpdate: $canUpdate, mcode: $mcode, canDaDownload: $canDaDownload, daDownloadUrl: $daDownloadUrl)';
  }
}

/// @nodoc
abstract mixin class _$AssignmentRecordEachCopyWith<$Res>
    implements $AssignmentRecordEachCopyWith<$Res> {
  factory _$AssignmentRecordEachCopyWith(_AssignmentRecordEach value,
          $Res Function(_AssignmentRecordEach) _then) =
      __$AssignmentRecordEachCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serialNumber,
      String assignmentTitle,
      String maxAssignmentMark,
      String assignmentWeightageMark,
      String dueDate,
      bool canQpDownload,
      String qpDownloadUrl,
      String submissionStatus,
      bool canUpdate,
      String mcode,
      bool canDaDownload,
      String daDownloadUrl});
}

/// @nodoc
class __$AssignmentRecordEachCopyWithImpl<$Res>
    implements _$AssignmentRecordEachCopyWith<$Res> {
  __$AssignmentRecordEachCopyWithImpl(this._self, this._then);

  final _AssignmentRecordEach _self;
  final $Res Function(_AssignmentRecordEach) _then;

  /// Create a copy of AssignmentRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serialNumber = null,
    Object? assignmentTitle = null,
    Object? maxAssignmentMark = null,
    Object? assignmentWeightageMark = null,
    Object? dueDate = null,
    Object? canQpDownload = null,
    Object? qpDownloadUrl = null,
    Object? submissionStatus = null,
    Object? canUpdate = null,
    Object? mcode = null,
    Object? canDaDownload = null,
    Object? daDownloadUrl = null,
  }) {
    return _then(_AssignmentRecordEach(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentTitle: null == assignmentTitle
          ? _self.assignmentTitle
          : assignmentTitle // ignore: cast_nullable_to_non_nullable
              as String,
      maxAssignmentMark: null == maxAssignmentMark
          ? _self.maxAssignmentMark
          : maxAssignmentMark // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentWeightageMark: null == assignmentWeightageMark
          ? _self.assignmentWeightageMark
          : assignmentWeightageMark // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      canQpDownload: null == canQpDownload
          ? _self.canQpDownload
          : canQpDownload // ignore: cast_nullable_to_non_nullable
              as bool,
      qpDownloadUrl: null == qpDownloadUrl
          ? _self.qpDownloadUrl
          : qpDownloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      submissionStatus: null == submissionStatus
          ? _self.submissionStatus
          : submissionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      canUpdate: null == canUpdate
          ? _self.canUpdate
          : canUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      mcode: null == mcode
          ? _self.mcode
          : mcode // ignore: cast_nullable_to_non_nullable
              as String,
      canDaDownload: null == canDaDownload
          ? _self.canDaDownload
          : canDaDownload // ignore: cast_nullable_to_non_nullable
              as bool,
      daDownloadUrl: null == daDownloadUrl
          ? _self.daDownloadUrl
          : daDownloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DigitalAssignments {
  String get serialNumber;
  String get classId;
  String get courseCode;
  String get courseTitle;
  String get courseType;
  String get faculty;
  List<AssignmentRecordEach> get details;

  /// Create a copy of DigitalAssignments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DigitalAssignmentsCopyWith<DigitalAssignments> get copyWith =>
      _$DigitalAssignmentsCopyWithImpl<DigitalAssignments>(
          this as DigitalAssignments, _$identity);

  /// Serializes this DigitalAssignments to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DigitalAssignments &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            const DeepCollectionEquality().equals(other.details, details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      classId,
      courseCode,
      courseTitle,
      courseType,
      faculty,
      const DeepCollectionEquality().hash(details));

  @override
  String toString() {
    return 'DigitalAssignments(serialNumber: $serialNumber, classId: $classId, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, faculty: $faculty, details: $details)';
  }
}

/// @nodoc
abstract mixin class $DigitalAssignmentsCopyWith<$Res> {
  factory $DigitalAssignmentsCopyWith(
          DigitalAssignments value, $Res Function(DigitalAssignments) _then) =
      _$DigitalAssignmentsCopyWithImpl;
  @useResult
  $Res call(
      {String serialNumber,
      String classId,
      String courseCode,
      String courseTitle,
      String courseType,
      String faculty,
      List<AssignmentRecordEach> details});
}

/// @nodoc
class _$DigitalAssignmentsCopyWithImpl<$Res>
    implements $DigitalAssignmentsCopyWith<$Res> {
  _$DigitalAssignmentsCopyWithImpl(this._self, this._then);

  final DigitalAssignments _self;
  final $Res Function(DigitalAssignments) _then;

  /// Create a copy of DigitalAssignments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serialNumber = null,
    Object? classId = null,
    Object? courseCode = null,
    Object? courseTitle = null,
    Object? courseType = null,
    Object? faculty = null,
    Object? details = null,
  }) {
    return _then(_self.copyWith(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _self.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      faculty: null == faculty
          ? _self.faculty
          : faculty // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<AssignmentRecordEach>,
    ));
  }
}

/// Adds pattern-matching-related methods to [DigitalAssignments].
extension DigitalAssignmentsPatterns on DigitalAssignments {
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
    TResult Function(_DigitalAssignments value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DigitalAssignments() when $default != null:
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
    TResult Function(_DigitalAssignments value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalAssignments():
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
    TResult? Function(_DigitalAssignments value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalAssignments() when $default != null:
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
            String serialNumber,
            String classId,
            String courseCode,
            String courseTitle,
            String courseType,
            String faculty,
            List<AssignmentRecordEach> details)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DigitalAssignments() when $default != null:
        return $default(_that.serialNumber, _that.classId, _that.courseCode,
            _that.courseTitle, _that.courseType, _that.faculty, _that.details);
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
            String serialNumber,
            String classId,
            String courseCode,
            String courseTitle,
            String courseType,
            String faculty,
            List<AssignmentRecordEach> details)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalAssignments():
        return $default(_that.serialNumber, _that.classId, _that.courseCode,
            _that.courseTitle, _that.courseType, _that.faculty, _that.details);
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
            String serialNumber,
            String classId,
            String courseCode,
            String courseTitle,
            String courseType,
            String faculty,
            List<AssignmentRecordEach> details)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalAssignments() when $default != null:
        return $default(_that.serialNumber, _that.classId, _that.courseCode,
            _that.courseTitle, _that.courseType, _that.faculty, _that.details);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DigitalAssignments implements DigitalAssignments {
  const _DigitalAssignments(
      {required this.serialNumber,
      required this.classId,
      required this.courseCode,
      required this.courseTitle,
      required this.courseType,
      required this.faculty,
      required final List<AssignmentRecordEach> details})
      : _details = details;
  factory _DigitalAssignments.fromJson(Map<String, dynamic> json) =>
      _$DigitalAssignmentsFromJson(json);

  @override
  final String serialNumber;
  @override
  final String classId;
  @override
  final String courseCode;
  @override
  final String courseTitle;
  @override
  final String courseType;
  @override
  final String faculty;
  final List<AssignmentRecordEach> _details;
  @override
  List<AssignmentRecordEach> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  /// Create a copy of DigitalAssignments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DigitalAssignmentsCopyWith<_DigitalAssignments> get copyWith =>
      __$DigitalAssignmentsCopyWithImpl<_DigitalAssignments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DigitalAssignmentsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DigitalAssignments &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      classId,
      courseCode,
      courseTitle,
      courseType,
      faculty,
      const DeepCollectionEquality().hash(_details));

  @override
  String toString() {
    return 'DigitalAssignments(serialNumber: $serialNumber, classId: $classId, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, faculty: $faculty, details: $details)';
  }
}

/// @nodoc
abstract mixin class _$DigitalAssignmentsCopyWith<$Res>
    implements $DigitalAssignmentsCopyWith<$Res> {
  factory _$DigitalAssignmentsCopyWith(
          _DigitalAssignments value, $Res Function(_DigitalAssignments) _then) =
      __$DigitalAssignmentsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serialNumber,
      String classId,
      String courseCode,
      String courseTitle,
      String courseType,
      String faculty,
      List<AssignmentRecordEach> details});
}

/// @nodoc
class __$DigitalAssignmentsCopyWithImpl<$Res>
    implements _$DigitalAssignmentsCopyWith<$Res> {
  __$DigitalAssignmentsCopyWithImpl(this._self, this._then);

  final _DigitalAssignments _self;
  final $Res Function(_DigitalAssignments) _then;

  /// Create a copy of DigitalAssignments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serialNumber = null,
    Object? classId = null,
    Object? courseCode = null,
    Object? courseTitle = null,
    Object? courseType = null,
    Object? faculty = null,
    Object? details = null,
  }) {
    return _then(_DigitalAssignments(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _self.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      faculty: null == faculty
          ? _self.faculty
          : faculty // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _self._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<AssignmentRecordEach>,
    ));
  }
}

// dart format on
