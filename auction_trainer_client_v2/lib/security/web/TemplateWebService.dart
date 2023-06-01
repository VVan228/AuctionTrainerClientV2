

import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateData.dart';
import 'package:auction_trainer_client_v2/security/model/TemplatePage.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'TemplateWebService.g.dart';

@RestApi()
abstract class TemplateWebService {
  factory TemplateWebService(Dio dio, {String baseUrl}) = _TemplateWebService;


  @GET('template/get/my')
  Future<TemplatePage> getMyTemplates(@Query("sortBy") String? sortBy, @Query("page") int? page);

  @GET('template/get/public')
  Future<TemplatePage> getPublicTemplates(@Query("sortBy") String? sortBy, @Query("page") int? page);

  @POST('template/create')
  Future<void> createTemplate(@Body() TemplateData templateData, @Query("isPrivate") bool isPrivate);

  @POST('template/approve')
  Future<void> approveTemplate(@Query("templateId") int templateId);

  @POST('template/unapprove')
  Future<void> unapproveTemplate(@Query("templateId") int templateId);

  @POST('template/delete')
  Future<void> deleteTemplate(@Query("templateId") int templateId);
}