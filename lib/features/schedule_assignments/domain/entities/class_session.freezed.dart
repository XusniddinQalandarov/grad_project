// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClassSession _$ClassSessionFromJson(Map<String, dynamic> json) {
  return _ClassSession.fromJson(json);
}

/// @nodoc
mixin _$ClassSession {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get dayOfWeek => throw _privateConstructorUsedError;
  String? get instructor => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ClassSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassSessionCopyWith<ClassSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassSessionCopyWith<$Res> {
  factory $ClassSessionCopyWith(
    ClassSession value,
    $Res Function(ClassSession) then,
  ) = _$ClassSessionCopyWithImpl<$Res, ClassSession>;
  @useResult
  $Res call({
    String id,
    String name,
    String room,
    String time,
    String dayOfWeek,
    String? instructor,
    String? description,
  });
}

/// @nodoc
class _$ClassSessionCopyWithImpl<$Res, $Val extends ClassSession>
    implements $ClassSessionCopyWith<$Res> {
  _$ClassSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? room = null,
    Object? time = null,
    Object? dayOfWeek = null,
    Object? instructor = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            room: null == room
                ? _value.room
                : room // ignore: cast_nullable_to_non_nullable
                      as String,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as String,
            instructor: freezed == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassSessionImplCopyWith<$Res>
    implements $ClassSessionCopyWith<$Res> {
  factory _$$ClassSessionImplCopyWith(
    _$ClassSessionImpl value,
    $Res Function(_$ClassSessionImpl) then,
  ) = __$$ClassSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String room,
    String time,
    String dayOfWeek,
    String? instructor,
    String? description,
  });
}

/// @nodoc
class __$$ClassSessionImplCopyWithImpl<$Res>
    extends _$ClassSessionCopyWithImpl<$Res, _$ClassSessionImpl>
    implements _$$ClassSessionImplCopyWith<$Res> {
  __$$ClassSessionImplCopyWithImpl(
    _$ClassSessionImpl _value,
    $Res Function(_$ClassSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? room = null,
    Object? time = null,
    Object? dayOfWeek = null,
    Object? instructor = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$ClassSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as String,
        instructor: freezed == instructor
            ? _value.instructor
            : instructor // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassSessionImpl implements _ClassSession {
  const _$ClassSessionImpl({
    required this.id,
    required this.name,
    required this.room,
    required this.time,
    required this.dayOfWeek,
    this.instructor,
    this.description,
  });

  factory _$ClassSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String room;
  @override
  final String time;
  @override
  final String dayOfWeek;
  @override
  final String? instructor;
  @override
  final String? description;

  @override
  String toString() {
    return 'ClassSession(id: $id, name: $name, room: $room, time: $time, dayOfWeek: $dayOfWeek, instructor: $instructor, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    room,
    time,
    dayOfWeek,
    instructor,
    description,
  );

  /// Create a copy of ClassSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassSessionImplCopyWith<_$ClassSessionImpl> get copyWith =>
      __$$ClassSessionImplCopyWithImpl<_$ClassSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassSessionImplToJson(this);
  }
}

abstract class _ClassSession implements ClassSession {
  const factory _ClassSession({
    required final String id,
    required final String name,
    required final String room,
    required final String time,
    required final String dayOfWeek,
    final String? instructor,
    final String? description,
  }) = _$ClassSessionImpl;

  factory _ClassSession.fromJson(Map<String, dynamic> json) =
      _$ClassSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get room;
  @override
  String get time;
  @override
  String get dayOfWeek;
  @override
  String? get instructor;
  @override
  String? get description;

  /// Create a copy of ClassSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassSessionImplCopyWith<_$ClassSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
