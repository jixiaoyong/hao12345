// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_urls_bean.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllUrlsBean _$AllUrlsBeanFromJson(Map<String, dynamic> json) {
  return _AllUrlsBean.fromJson(json);
}

/// @nodoc
mixin _$AllUrlsBean {
  int? get version => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  List<Results>? get results => throw _privateConstructorUsedError;

  /// Serializes this AllUrlsBean to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllUrlsBean
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllUrlsBeanCopyWith<AllUrlsBean> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllUrlsBeanCopyWith<$Res> {
  factory $AllUrlsBeanCopyWith(
          AllUrlsBean value, $Res Function(AllUrlsBean) then) =
      _$AllUrlsBeanCopyWithImpl<$Res, AllUrlsBean>;
  @useResult
  $Res call({int? version, String? updatedAt, List<Results>? results});
}

/// @nodoc
class _$AllUrlsBeanCopyWithImpl<$Res, $Val extends AllUrlsBean>
    implements $AllUrlsBeanCopyWith<$Res> {
  _$AllUrlsBeanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllUrlsBean
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
    Object? updatedAt = freezed,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Results>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllUrlsBeanImplCopyWith<$Res>
    implements $AllUrlsBeanCopyWith<$Res> {
  factory _$$AllUrlsBeanImplCopyWith(
          _$AllUrlsBeanImpl value, $Res Function(_$AllUrlsBeanImpl) then) =
      __$$AllUrlsBeanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? version, String? updatedAt, List<Results>? results});
}

/// @nodoc
class __$$AllUrlsBeanImplCopyWithImpl<$Res>
    extends _$AllUrlsBeanCopyWithImpl<$Res, _$AllUrlsBeanImpl>
    implements _$$AllUrlsBeanImplCopyWith<$Res> {
  __$$AllUrlsBeanImplCopyWithImpl(
      _$AllUrlsBeanImpl _value, $Res Function(_$AllUrlsBeanImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllUrlsBean
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
    Object? updatedAt = freezed,
    Object? results = freezed,
  }) {
    return _then(_$AllUrlsBeanImpl(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Results>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllUrlsBeanImpl implements _AllUrlsBean {
  const _$AllUrlsBeanImpl(
      {this.version, this.updatedAt, final List<Results>? results})
      : _results = results;

  factory _$AllUrlsBeanImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllUrlsBeanImplFromJson(json);

  @override
  final int? version;
  @override
  final String? updatedAt;
  final List<Results>? _results;
  @override
  List<Results>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AllUrlsBean(version: $version, updatedAt: $updatedAt, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllUrlsBeanImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, updatedAt,
      const DeepCollectionEquality().hash(_results));

  /// Create a copy of AllUrlsBean
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllUrlsBeanImplCopyWith<_$AllUrlsBeanImpl> get copyWith =>
      __$$AllUrlsBeanImplCopyWithImpl<_$AllUrlsBeanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllUrlsBeanImplToJson(
      this,
    );
  }
}

abstract class _AllUrlsBean implements AllUrlsBean {
  const factory _AllUrlsBean(
      {final int? version,
      final String? updatedAt,
      final List<Results>? results}) = _$AllUrlsBeanImpl;

  factory _AllUrlsBean.fromJson(Map<String, dynamic> json) =
      _$AllUrlsBeanImpl.fromJson;

  @override
  int? get version;
  @override
  String? get updatedAt;
  @override
  List<Results>? get results;

  /// Create a copy of AllUrlsBean
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllUrlsBeanImplCopyWith<_$AllUrlsBeanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return _Results.fromJson(json);
}

/// @nodoc
mixin _$Results {
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get objectId => throw _privateConstructorUsedError;

  /// Serializes this Results to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Results
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResultsCopyWith<Results> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultsCopyWith<$Res> {
  factory $ResultsCopyWith(Results value, $Res Function(Results) then) =
      _$ResultsCopyWithImpl<$Res, Results>;
  @useResult
  $Res call(
      {String? name,
      String? url,
      String? description,
      String? createdAt,
      String? updatedAt,
      String? objectId});
}

/// @nodoc
class _$ResultsCopyWithImpl<$Res, $Val extends Results>
    implements $ResultsCopyWith<$Res> {
  _$ResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Results
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? description = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ResultsImplCopyWith<$Res> implements $ResultsCopyWith<$Res> {
  factory _$$ResultsImplCopyWith(
          _$ResultsImpl value, $Res Function(_$ResultsImpl) then) =
      __$$ResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? url,
      String? description,
      String? createdAt,
      String? updatedAt,
      String? objectId});
}

/// @nodoc
class __$$ResultsImplCopyWithImpl<$Res>
    extends _$ResultsCopyWithImpl<$Res, _$ResultsImpl>
    implements _$$ResultsImplCopyWith<$Res> {
  __$$ResultsImplCopyWithImpl(
      _$ResultsImpl _value, $Res Function(_$ResultsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Results
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? objectId = freezed,
  }) {
    return _then(_$ResultsImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$ResultsImpl implements _Results {
  const _$ResultsImpl(
      {this.name,
      this.url,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.objectId});

  factory _$ResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultsImplFromJson(json);

  @override
  final String? name;
  @override
  final String? url;
  @override
  final String? description;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  final String? objectId;

  @override
  String toString() {
    return 'Results(name: $name, url: $url, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, objectId: $objectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultsImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
      runtimeType, name, url, description, createdAt, updatedAt, objectId);

  /// Create a copy of Results
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultsImplCopyWith<_$ResultsImpl> get copyWith =>
      __$$ResultsImplCopyWithImpl<_$ResultsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultsImplToJson(
      this,
    );
  }
}

abstract class _Results implements Results {
  const factory _Results(
      {final String? name,
      final String? url,
      final String? description,
      final String? createdAt,
      final String? updatedAt,
      final String? objectId}) = _$ResultsImpl;

  factory _Results.fromJson(Map<String, dynamic> json) = _$ResultsImpl.fromJson;

  @override
  String? get name;
  @override
  String? get url;
  @override
  String? get description;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  String? get objectId;

  /// Create a copy of Results
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultsImplCopyWith<_$ResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
