import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/auction/impl/AuctionPage.dart';
import 'package:auction_trainer_client_v2/pages/create_room/impl/CreatePage.dart';
import 'package:auction_trainer_client_v2/pages/main/api/MainPresenter.dart';
import 'package:auction_trainer_client_v2/pages/main/api/MainView.dart';
import 'package:auction_trainer_client_v2/pages/select_template/impl/SelectTemplatePage.dart';
import 'package:auction_trainer_client_v2/pages/waiting/impl/WaintingPage.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements MainView {
  final _roomController = TextEditingController();

  MainPresenter presenter = getIt<MainPresenter>();
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          children: [
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.edit),
              onPressed: () {
                presenter.createClick();
              },
            ),
            FloatingActionButton.small(
                heroTag: null,
                child: const Icon(Icons.search),
                onPressed: () {
                  var res = showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Text(
                                "Enter room id",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            Text(
                              errorMsg,
                              style: const TextStyle(color: Colors.red),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text("roomId"),
                                ),
                                controller: _roomController,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, "");
                                  },
                                  child: const Text('Close'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, _roomController.text);
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  res.then((value) => presenter.roomIdEntered(value!));
                }),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
              child: Text(
                "Приветствую, " + getIt<TokenService>().getUser().username,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    presenter.setView(this);
  }

  @override
  void openWaitPage(Room room) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WaitingPage(room: room)),
    );
  }

  @override
  void showErrorMsg(String error) {
    setState(() {
      errorMsg = error;
    });
  }

  @override
  void openAuctionPage(Room room) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuctionPage(room: room)),
    );
  }

  @override
  void openCreatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectTemplatePage()),
    );
  }
}

class SearchDialog extends StatelessWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
