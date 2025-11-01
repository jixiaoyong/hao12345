// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_urls_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllUrlsBeanImpl _$$AllUrlsBeanImplFromJson(Map<String, dynamic> json) =>
    _$AllUrlsBeanImpl(
      version: (json['version'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AllUrlsBeanImplToJson(_$AllUrlsBeanImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'updatedAt': instance.updatedAt,
      'results': instance.results,
    };

_$ResultsImpl _$$ResultsImplFromJson(Map<String, dynamic> json) =>
    _$ResultsImpl(
      name: json['name'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$$ResultsImplToJson(_$ResultsImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
    };
