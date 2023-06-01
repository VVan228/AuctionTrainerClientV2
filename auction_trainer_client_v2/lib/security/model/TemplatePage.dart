

import 'package:json_annotation/json_annotation.dart';

import 'Template.dart';

part 'TemplatePage.g.dart';

@JsonSerializable()
class TemplatePage {
  List<Template> content;
  bool last;
  int totalPages;
  int size;
  int number;
  int numberOfElements;

  TemplatePage({required this.content,required this.last,required this.totalPages,required this.size,required this.number,required this.numberOfElements,});

  factory TemplatePage.fromJson(Map<String, dynamic> json) => _$TemplatePageFromJson(json);
  Map<String, dynamic> toJson() => _$TemplatePageToJson(this);
}