// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateRoomRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRoomRequest _$CreateRoomRequestFromJson(Map<String, dynamic> json) =>
    CreateRoomRequest(
      name: json['name'] as String,
      startTime: CreateRoomRequest._fromJson(json['startTime'] as String?),
      templateId: json['templateId'] as int,
      lots: (json['lots'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => LotRequest.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$CreateRoomRequestToJson(CreateRoomRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startTime': CreateRoomRequest._toJson(instance.startTime),
      'templateId': instance.templateId,
      'lots': instance.lots,
    };
