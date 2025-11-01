// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nav_bean.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NavBean _$NavBeanFromJson(Map<String, dynamic> json) {
  return _NavBean.fromJson(json);
}

/// @nodoc
mixin _$NavBean {
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int? get pubTimestamp => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get objectId => throw _privateConstructorUsedError;

  /// Serializes this NavBean to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NavBean
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavBeanCopyWith<NavBean> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavBeanCopyWith<$Res> {
  factory $NavBeanCopyWith(NavBean value, $Res Function(NavBean) then) =
      _$NavBeanCopyWithImpl<$Res, NavBean>;
  @useResult
  $Res call(
      {String? name,
      String? url,
      int? pubTimestamp,
      String? createdAt,
      String? updatedAt,
      String? objectId});
}

/// @nodoc
class _$NavBeanCopyWithImpl<$Res, $Val extends NavBean>
    implements $NavBeanCopyWith<$Res> {
  _$NavBeanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavBean
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? pubTimestamp = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? objectId = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      pubTimestamp: freezed == pubTimestamp
          ? _value.pubTimestamp
          : pubTimestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      objectId: freezed == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavBeanImplCopyWith<$Res> implements $NavBeanCopyWith<$Res> {
  factory _$$NavBeanImplCopyWith(
          _$NavBeanImpl value, $Res Function(_$NavBeanImpl) then) =
      __$$NavBeanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? url,
      int? pubTimestamp,
      String? createdAt,
      String? updatedAt,
      String? objectId});
}

/// @nodoc
class __$$NavBeanImplCopyWithImpl<$Res>
    extends _$NavBeanCopyWithImpl<$Res, _$NavBeanImpl>
    implements _$$NavBeanImplCopyWith<$Res> {
  __$$NavBeanImplCopyWithImpl(
      _$NavBeanImpl _value, $Res Function(_$NavBeanImpl) _then)
      : super(_value, _then);

  /// Create a copy of NavBean
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? pubTimestamp = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? objectId = freezed,
  }) {
    return _then(_$NavBeanImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      pubTimestamp: freezed == pubTimestamp
          ? _value.pubTimestamp
          : pubTimestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      objectId: freezed == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NavBeanImpl implements _NavBean {
  const _$NavBeanImpl(
      {this.name,
      this.url,
      this.pubTimestamp,
      this.createdAt,
      this.updatedAt,
      this.objectId});

  factory _$NavBeanImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavBeanImplFromJson(json);

  @override
  final String? name;
  @override
  final String? url;
  @override
  final int? pubTimestamp;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  final String? objectId;

  @override
  String toString() {
    return 'NavBean(name: $name, url: $url, pubTimestamp: $pubTimestamp, createdAt: $createdAt, updatedAt: $updatedAt, objectId: $objectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavBeanImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.pubTimestamp, pubTimestamp) ||
                other.pubTimestamp == pubTimestamp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, url, pubTimestamp, createdAt, updatedAt, objectId);

  /// Create a copy of NavBean
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavBeanImplCopyWith<_$NavBeanImpl> get copyWith =>
      __$$NavBeanImplCopyWithImpl<_$NavBeanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NavBeanImplToJson(
      this,
    );
  }
}

abstract class _NavBean implements NavBean {
  const factory _NavBean(
      {final String? name,
      final String? url,
      final int? pubTimestamp,
      final String? createdAt,
      final String? updatedAt,
      final String? objectId}) = _$NavBeanImpl;

  factory _NavBean.fromJson(Map<String, dynamic> json) = _$NavBeanImpl.fromJson;

  @override
  String? get name;
  @override
  String? get url;
  @override
  int? get pubTimestamp;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  String? get objectId;

  /// Create a copy of NavBean
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavBeanImplCopyWith<_$NavBeanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
