import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/create_room/impl/CreatePage.dart';
import 'package:auction_trainer_client_v2/pages/create_template/CreateTemplatePage.dart';
import 'package:auction_trainer_client_v2/pages/select_template/api/SelectTemplatePresenter.dart';
import 'package:auction_trainer_client_v2/pages/select_template/api/SelectTemplateView.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateData.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateRound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SelectTemplatePage extends StatelessWidget {
  const SelectTemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select template"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.archive)),
              Tab(icon: Icon(Icons.format_list_bulleted)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SelectMyTemplate(searchMode: false),
            SelectMyTemplate(searchMode: true),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                getIt<SelectTemplatePresenter>().newTemplateClick();
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: 5,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: const Icon(Icons.skip_next),
            )
          ],
        ),
      ),
    );
  }
}

class _SelectMyTemplateState extends State<SelectMyTemplate>
    implements SelectTemplateView {
  SelectTemplatePresenter? presenter;
  int pageSize = 20;
  final PagingController<int, Template> _pagingController =
      PagingController(firstPageKey: 0);

  List<String> searchOptions = ["View", "Copy", "Add", "Select"];
  List<String> myOptions = ["View", "Copy", "Select"];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: PagedListView<int, Template>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Template>(
              itemBuilder: (context, item, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
              child: ListTile(
                  //   if(e == "View") {
                  // presenter?.viewTemplateClick(item.data);
                  // }
                  //     if(e == "Copy") {
                  //   presenter?.copyTemplateClick(item.data);
                  // }
                  // if(e == "Add") {
                  //   presenter?.approveTemplateClick(item);
                  // }
                  // if(e == "Select") {
                  //   //TODO:
                  // }
                  leading: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 100, minWidth: 40),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                          ),
                          onPressed: () {
                            presenter?.viewTemplateClick(item.data);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                            size: 20,
                          ),
                          onPressed: () {
                            presenter?.copyTemplateClick(item.data);
                          },
                        ),
                      ],
                    ),
                  ),
                  title: Text(item.data.templateName),
                  trailing: Column(
                    children: [
                      Visibility(
                        visible: widget.searchMode,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  presenter?.approveTemplateClick(item);
                                },
                                icon: const Icon(
                                  Icons.save,
                                )),
                            Text("${item.approvesAmount}")
                          ],
                        ),
                      ),
                      Visibility(
                          visible: !widget.searchMode,
                          child: item.creator.username ==
                                  getIt<TokenService>().getUser().username
                              ? IconButton(
                                  onPressed: () {
                                    presenter?.deleteTemplateClick(item);
                                  },
                                  icon: const Icon((Icons.publish)))
                              : item.isDefault
                                  ? const IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.settings))
                                  : IconButton(
                                      icon: const Icon(Icons.bookmark),
                                      onPressed: () {
                                        presenter?.unapproveTemplateClick(item);
                                      },
                                    )),
                    ],
                  ),
                  subtitle: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 10, minHeight: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item.data.rounds.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int i) {
                          return Icon(item.data.rounds[i].ascending
                              ? Icons.keyboard_arrow_up_sharp
                              : Icons.keyboard_arrow_down_sharp);
                        }),
                  ),
                  // ToggleButtons(
                  //   direction: Axis.horizontal,
                  //   isSelected:
                  //       widget.searchMode?
                  //         searchOptions.map((e) => false).toList()
                  //       :
                  //         myOptions.map((e) => false).toList()
                  //   ,
                  //   children:
                  //     widget.searchMode?
                  //       searchOptions.map((e) => Text(e)).toList()
                  //     :
                  //       myOptions.map((e) => Text(e)).toList()
                  //   ,
                  //   selectedColor: Theme.of(context).primaryColorDark,
                  //   borderColor: Theme.of(context).scaffoldBackgroundColor,
                  //   selectedBorderColor: Theme.of(context).scaffoldBackgroundColor,
                  //   onPressed: widget.viewMode?(int i){}:(int i) {
                  //     if(i==0) {
                  //       setManualMode(true);
                  //     }else {
                  //       setManualMode(false);
                  //     }
                  //   },
                  // )
                  onTap: () {
                    presenter?.selectTemplateClick(item);
                  }),
            );
          }),
        ),
        onRefresh: () async {
          presenter?.manualUpdate();
        });
  }

  @override
  void initState() {
    super.initState();
    presenter = getIt<SelectTemplatePresenter>();
    presenter?.setView(this, widget.searchMode);
    _pagingController.addPageRequestListener((pageKey) {
      presenter?.fetchPage(pageKey);
    });
  }

  @override
  void appendLastPage(List<Template> templates) {
    _pagingController.appendLastPage(templates);
  }

  @override
  void appendPage(List<Template> templates, int nextPage) {
    _pagingController.appendPage(templates, nextPage);
  }

  @override
  void showPageError(String err) {
    _pagingController.error = err;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void updateList() {
    _pagingController.refresh();
  }

  @override
  Future<TemplateData?> openNewTemplatePage() async {
    return Navigator.push<TemplateData>(
      context,
      MaterialPageRoute(
          builder: (context) => CreateTemplatePage(
                viewMode: false,
                templateData: TemplateData(
                    manualMode: false,
                    templateName: "",
                    lotNames: [],
                    lotDescriptions: [],
                    rounds: []),
              )),
    );
  }

  @override
  Future<TemplateData?> openCopyTemplatePage(TemplateData data) {
    return Navigator.push<TemplateData>(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CreateTemplatePage(viewMode: false, templateData: data)),
    );
  }

  @override
  void openViewTemplatePage(TemplateData data) {
    print("view page open" + data.toJson().toString());
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CreateTemplatePage(viewMode: true, templateData: data)),
    );
  }

  @override
  void openCreateRoomPage(Template template) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateRoomPage(template: template)),
    );
  }
}

class SelectMyTemplate extends StatefulWidget {
  const SelectMyTemplate({Key? key, required this.searchMode})
      : super(key: key);

  final bool searchMode;

  @override
  State<StatefulWidget> createState() => _SelectMyTemplateState();
}
