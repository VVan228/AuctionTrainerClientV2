
import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateData.dart';

abstract class SelectTemplateView {
  void showPageError(String err);
  void appendLastPage(List<Template> templates);
  void appendPage(List<Template> templates, int nextPage);
  void updateList();
  Future<TemplateData?> openNewTemplatePage();
  Future<TemplateData?> openCopyTemplatePage(TemplateData data);
  void openViewTemplatePage(TemplateData data);
  void openCreateRoomPage(Template template);
}