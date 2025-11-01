// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NavBeanImpl _$$NavBeanImplFromJson(Map<String, dynamic> json) =>
    _$NavBeanImpl(
      name: json['name'] as String?,
      url: json['url'] as String?,
      pubTimestamp: (json['pubTimestamp'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$$NavBeanImplToJson(_$NavBeanImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'pubTimestamp': instance.pubTimestamp,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
    };
