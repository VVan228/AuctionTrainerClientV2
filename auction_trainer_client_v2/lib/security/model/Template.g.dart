// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      id: json['id'] as int,
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      approvesAmount: json['approvesAmount'] as int,
      creationTime: DateTime.parse(json['creationTime'] as String),
      data: TemplateData.fromJson(json['data'] as Map<String, dynamic>),
      isDefault: json['isDefault'] as bool,
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'creator': instance.creator,
      'approvesAmount': instance.approvesAmount,
      'creationTime': instance.creationTime.toIso8601String(),
      'data': instance.data,
      'isDefault': instance.isDefault,
      'id': instance.id,
    };
