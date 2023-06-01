// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      connectedUsers: (json['connectedUsers'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      startTime: Room._fromJson(json['startTime'] as String?),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => Round.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      name: json['name'] as String,
      status: Room._statusFromJson(json['status'] as String),
      id: json['id'] as int,
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'startTime': Room._toJson(instance.startTime),
      'creator': instance.creator,
      'name': instance.name,
      'status': Room._statusToJson(instance.status),
      'id': instance.id,
      'rounds': instance.rounds,
      'connectedUsers': instance.connectedUsers,
    };
