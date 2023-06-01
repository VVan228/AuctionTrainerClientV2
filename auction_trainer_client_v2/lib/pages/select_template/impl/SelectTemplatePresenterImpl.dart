

import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/select_template/api/SelectTemplatePresenter.dart';
import 'package:auction_trainer_client_v2/pages/select_template/api/SelectTemplateView.dart';
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateData.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:auction_trainer_client_v2/security/web/TemplateWebService.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SelectTemplatePresenter)
class SelectTemplatePresenterImpl implements SelectTemplatePresenter{

  SelectTemplateView? view;
  bool searchMode = false;
  String? sortBy;

  @override
  void setView(SelectTemplateView view, bool searchMode) async {
    this.searchMode = searchMode;
    this.view = view;
  }

  @override
  void fetchPage(int page) async {
    var templateClient = TemplateWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );

    if(!searchMode) {
      getMyTemplates(templateClient, page);
    } else{
      getAllTemplates(templateClient, page);
    }
  }

  void getAllTemplates(TemplateWebService templateClient, int page) {
    templateClient.getPublicTemplates(sortBy, page).then((value) {
      if (value.last) {
        view?.appendLastPage(value.content);
      } else {
        view?.appendPage(value.content, page+1);
      }

    }).catchError((err) {
      view?.showPageError(err);
    });
  }

  void getMyTemplates(TemplateWebService templateClient, int page) {
    templateClient.getMyTemplates(null, page).then((value) {
      if (value.last) {
        view?.appendLastPage(value.content);
      } else {
        view?.appendPage(value.content, page+1);
      }

    }).catchError((err) {
      view?.showPageError(err);
    });
  }

  @override
  Future<void> manualUpdate() async {
    view?.updateList();
  }

  @override
  void setSortBy(SortType sort) {
    sortBy = sortToString(sort);
  }

  @override
  void newTemplateClick() async {
    var templateClient = TemplateWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    TemplateData? res = await view?.openNewTemplatePage();
    if(res == null) return;
    templateClient.createTemplate(res, false).then((value) => view?.updateList());
  }

  @override
  void copyTemplateClick(TemplateData data) async {
    var templateClient = TemplateWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    TemplateData? res = await view?.openCopyTemplatePage(data);
    if(res == null) return;
    templateClient.createTemplate(res, false).then((value) => view?.updateList());
  }

  @override
  void viewTemplateClick(TemplateData data) {
    print("view click");
    view?.openViewTemplatePage(data);
  }

  @override
  void approveTemplateClick(Template template) async {
    var templateClient = TemplateWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    templateClient.approveTemplate(template.id).then((value) => view?.updateList()).catchError((err)=>view?.showPageError(err.toString()));
  }

  @override
  void unapproveTemplateClick(Template template) async {
    var templateClient = TemplateWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    templateClient.unapproveTemplate(template.id).then((value) => view?.updateList()).catchError((err)=>view?.showPageError(err.toString()));

  }

  @override
  void deleteTemplateClick(Template template) async {
    var templateClient = TemplateWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    templateClient.deleteTemplate(template.id).then((value) => view?.updateList()).catchError((err)=>view?.showPageError(err.toString()));

  }

  @override
  void selectTemplateClick(Template template) {
    view?.openCreateRoomPage(template);
  }

}