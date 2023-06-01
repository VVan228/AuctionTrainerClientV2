// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TemplatePage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplatePage _$TemplatePageFromJson(Map<String, dynamic> json) => TemplatePage(
      content: (json['content'] as List<dynamic>)
          .map((e) => Template.fromJson(e as Map<String, dynamic>))
          .toList(),
      last: json['last'] as bool,
      totalPages: json['totalPages'] as int,
      size: json['size'] as int,
      number: json['number'] as int,
      numberOfElements: json['numberOfElements'] as int,
    );

Map<String, dynamic> _$TemplatePageToJson(TemplatePage instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'size': instance.size,
      'number': instance.number,
      'numberOfElements': instance.numberOfElements,
    };
