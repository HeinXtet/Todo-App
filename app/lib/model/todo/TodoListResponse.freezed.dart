// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'TodoListResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoListResponse _$TodoListResponseFromJson(Map<String, dynamic> json) {
  return _TodoListResponse.fromJson(json);
}

/// @nodoc
mixin _$TodoListResponse {
  List<Todo> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoListResponseCopyWith<TodoListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListResponseCopyWith<$Res> {
  factory $TodoListResponseCopyWith(
          TodoListResponse value, $Res Function(TodoListResponse) then) =
      _$TodoListResponseCopyWithImpl<$Res, TodoListResponse>;
  @useResult
  $Res call({List<Todo> data});
}

/// @nodoc
class _$TodoListResponseCopyWithImpl<$Res, $Val extends TodoListResponse>
    implements $TodoListResponseCopyWith<$Res> {
  _$TodoListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoListResponseImplCopyWith<$Res>
    implements $TodoListResponseCopyWith<$Res> {
  factory _$$TodoListResponseImplCopyWith(_$TodoListResponseImpl value,
          $Res Function(_$TodoListResponseImpl) then) =
      __$$TodoListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Todo> data});
}

/// @nodoc
class __$$TodoListResponseImplCopyWithImpl<$Res>
    extends _$TodoListResponseCopyWithImpl<$Res, _$TodoListResponseImpl>
    implements _$$TodoListResponseImplCopyWith<$Res> {
  __$$TodoListResponseImplCopyWithImpl(_$TodoListResponseImpl _value,
      $Res Function(_$TodoListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$TodoListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoListResponseImpl implements _TodoListResponse {
  const _$TodoListResponseImpl({required final List<Todo> data}) : _data = data;

  factory _$TodoListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoListResponseImplFromJson(json);

  final List<Todo> _data;
  @override
  List<Todo> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'TodoListResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoListResponseImplCopyWith<_$TodoListResponseImpl> get copyWith =>
      __$$TodoListResponseImplCopyWithImpl<_$TodoListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoListResponseImplToJson(
      this,
    );
  }
}

abstract class _TodoListResponse implements TodoListResponse {
  const factory _TodoListResponse({required final List<Todo> data}) =
      _$TodoListResponseImpl;

  factory _TodoListResponse.fromJson(Map<String, dynamic> json) =
      _$TodoListResponseImpl.fromJson;

  @override
  List<Todo> get data;
  @override
  @JsonKey(ignore: true)
  _$$TodoListResponseImplCopyWith<_$TodoListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
