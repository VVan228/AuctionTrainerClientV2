
import 'package:auction_trainer_client_v2/pages/select_template/api/SelectTemplateView.dart';
import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateData.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';

abstract class SelectTemplatePresenter {
  void setView(SelectTemplateView view, bool searchMode);
  void fetchPage(int page);
  Future<void> manualUpdate();
  void setSortBy(SortType sort);
  void newTemplateClick();
  void viewTemplateClick(TemplateData data);
  void copyTemplateClick(TemplateData data);
  void approveTemplateClick(Template template);
  void unapproveTemplateClick(Template template);
  void deleteTemplateClick(Template template);
  void selectTemplateClick(Template template);
}