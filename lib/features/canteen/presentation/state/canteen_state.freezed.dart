// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canteen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CanteenState {
  List<MenuItem> get menuItems => throw _privateConstructorUsedError;
  List<String> get selectedTags => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;

  /// Create a copy of CanteenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CanteenStateCopyWith<CanteenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanteenStateCopyWith<$Res> {
  factory $CanteenStateCopyWith(
    CanteenState value,
    $Res Function(CanteenState) then,
  ) = _$CanteenStateCopyWithImpl<$Res, CanteenState>;
  @useResult
  $Res call({
    List<MenuItem> menuItems,
    List<String> selectedTags,
    bool isLoading,
    String? errorMessage,
    DateTime selectedDate,
  });
}

/// @nodoc
class _$CanteenStateCopyWithImpl<$Res, $Val extends CanteenState>
    implements $CanteenStateCopyWith<$Res> {
  _$CanteenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CanteenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItems = null,
    Object? selectedTags = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? selectedDate = null,
  }) {
    return _then(
      _value.copyWith(
            menuItems: null == menuItems
                ? _value.menuItems
                : menuItems // ignore: cast_nullable_to_non_nullable
                      as List<MenuItem>,
            selectedTags: null == selectedTags
                ? _value.selectedTags
                : selectedTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedDate: null == selectedDate
                ? _value.selectedDate
                : selectedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CanteenStateImplCopyWith<$Res>
    implements $CanteenStateCopyWith<$Res> {
  factory _$$CanteenStateImplCopyWith(
    _$CanteenStateImpl value,
    $Res Function(_$CanteenStateImpl) then,
  ) = __$$CanteenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MenuItem> menuItems,
    List<String> selectedTags,
    bool isLoading,
    String? errorMessage,
    DateTime selectedDate,
  });
}

/// @nodoc
class __$$CanteenStateImplCopyWithImpl<$Res>
    extends _$CanteenStateCopyWithImpl<$Res, _$CanteenStateImpl>
    implements _$$CanteenStateImplCopyWith<$Res> {
  __$$CanteenStateImplCopyWithImpl(
    _$CanteenStateImpl _value,
    $Res Function(_$CanteenStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CanteenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItems = null,
    Object? selectedTags = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? selectedDate = null,
  }) {
    return _then(
      _$CanteenStateImpl(
        menuItems: null == menuItems
            ? _value._menuItems
            : menuItems // ignore: cast_nullable_to_non_nullable
                  as List<MenuItem>,
        selectedTags: null == selectedTags
            ? _value._selectedTags
            : selectedTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedDate: null == selectedDate
            ? _value.selectedDate
            : selectedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$CanteenStateImpl implements _CanteenState {
  const _$CanteenStateImpl({
    final List<MenuItem> menuItems = const [],
    final List<String> selectedTags = const [],
    this.isLoading = true,
    this.errorMessage,
    required this.selectedDate,
  }) : _menuItems = menuItems,
       _selectedTags = selectedTags;

  final List<MenuItem> _menuItems;
  @override
  @JsonKey()
  List<MenuItem> get menuItems {
    if (_menuItems is EqualUnmodifiableListView) return _menuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuItems);
  }

  final List<String> _selectedTags;
  @override
  @JsonKey()
  List<String> get selectedTags {
    if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTags);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final DateTime selectedDate;

  @override
  String toString() {
    return 'CanteenState(menuItems: $menuItems, selectedTags: $selectedTags, isLoading: $isLoading, errorMessage: $errorMessage, selectedDate: $selectedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanteenStateImpl &&
            const DeepCollectionEquality().equals(
              other._menuItems,
              _menuItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedTags,
              _selectedTags,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_menuItems),
    const DeepCollectionEquality().hash(_selectedTags),
    isLoading,
    errorMessage,
    selectedDate,
  );

  /// Create a copy of CanteenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CanteenStateImplCopyWith<_$CanteenStateImpl> get copyWith =>
      __$$CanteenStateImplCopyWithImpl<_$CanteenStateImpl>(this, _$identity);
}

abstract class _CanteenState implements CanteenState {
  const factory _CanteenState({
    final List<MenuItem> menuItems,
    final List<String> selectedTags,
    final bool isLoading,
    final String? errorMessage,
    required final DateTime selectedDate,
  }) = _$CanteenStateImpl;

  @override
  List<MenuItem> get menuItems;
  @override
  List<String> get selectedTags;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  DateTime get selectedDate;

  /// Create a copy of CanteenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CanteenStateImplCopyWith<_$CanteenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
