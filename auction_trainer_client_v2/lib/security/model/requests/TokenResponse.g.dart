// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TokenResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      email: json['email'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
