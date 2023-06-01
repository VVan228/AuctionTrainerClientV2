


import 'package:auction_trainer_client_v2/security/model/User.dart';
import 'package:json_annotation/json_annotation.dart';

import 'TemplateData.dart';

part 'Template.g.dart';

@JsonSerializable()
class Template {
  User creator;
  int approvesAmount;
  DateTime creationTime;
  TemplateData data;
  bool isDefault;
  int id;

  Template({required this.id, required this.creator,required this.approvesAmount,required this.creationTime,required this.data,required this.isDefault});

  factory Template.fromJson(Map<String, dynamic> json) => _$TemplateFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateToJson(this);
}
