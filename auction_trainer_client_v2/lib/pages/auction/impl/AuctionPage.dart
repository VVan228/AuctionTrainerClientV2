import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/auction/api/AuctionPresenter.dart';
import 'package:auction_trainer_client_v2/pages/auction/api/AuctionView.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/ParticipantBet.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:auction_trainer_client_v2/security/model/User.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({Key? key, required this.room}) : super(key: key);

  final Room room;

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> implements AuctionView{

  String user = getIt<TokenService>().getUser().username;
  bool isAdmin = false;

  var presenter = getIt<AuctionPresenter>();
  bool isLogged = false;
  Map<int, int?> bets = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.room.status==Status.ONGOING?"Ongoing room":"Ended room")
        ),
        floatingActionButton: Visibility(
            child: FloatingActionButton(
              child: Icon(Icons.send),
              onPressed: () {
                presenter.sendNextPoint();
              },
            ),
          visible: isAdmin,
        ),
        backgroundColor: Theme.of(context).shadowColor,
        body: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 2500, minWidth: 200),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.room.rounds.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctxt, int i) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    color: widget.room.rounds[i].status == Status.ONGOING
                        ? Theme.of(context).primaryColor.withOpacity(0.15)
                        : Theme.of(context).scaffoldBackgroundColor,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ListView.builder(
                            itemCount: widget.room.rounds[i].lots.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx2, int j) {
                              var _betController = TextEditingController();
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  //alignment: Alignment.center,
                                  //padding: EdgeInsets.symmetric(vertical: 20),
                                  //color: Theme.of(context).primaryColorLight,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                right: 10),
                                                        child: Text(
                                                          widget.room.rounds[i]
                                                              .lots[j].name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                      ),
                                                      Text(
                                                        widget
                                                            .room
                                                            .rounds[i]
                                                            .lots[j]
                                                            .description,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      )
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      widget
                                                          .room
                                                          .rounds[i]
                                                          .lots[j]
                                                          .betParams
                                                          .startSum
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Icon(widget
                                                                  .room
                                                                  .rounds[i]
                                                                  .ascending
                                                          ? Icons
                                                              .keyboard_arrow_up_sharp
                                                          : Icons
                                                              .keyboard_arrow_down_sharp),
                                                    ),
                                                    Text(
                                                      widget
                                                          .room
                                                          .rounds[i]
                                                          .lots[j]
                                                          .betParams
                                                          .limitSum
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    )
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                            )),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget
                                              .room.rounds[i].lots[j].status ==
                                          Status.ONGOING && !isAdmin,
                                      child: SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  enabled: isActive(i, j, widget
                                                      .room.rounds[i].lots[j].intervalId),
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.number,
                                                  decoration:
                                                  InputDecoration(
                                                    label: Text(
                                                        bets[widget
                                                            .room.rounds[i].lots[j].intervalId]==null?"bet":
                                                        bets[widget
                                                            .room.rounds[i].lots[j].intervalId].toString()),
                                                  ),
                                                  controller: _betController,
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 7),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_back,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 2),
                                                          child: OutlinedButton(
                                                              onPressed: () {
                                                                presenter.makeBet(
                                                                    widget.room.rounds[i].lots[j].intervalId,
                                                                    int.parse(_betController.text));
                                                              },
                                                              child: const Text(
                                                                  "send!")),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            )),
                                      ),
                                    ),
                                    Visibility(
                                        child: Icon(Icons.access_time),
                                      visible: widget
                                          .room.rounds[i].lots[j].status ==
                                          Status.ONGOING && isAdmin,
                                    ),
                                    Visibility(
                                      visible: widget
                                          .room.rounds[i].lots[j].winner !=
                                          null,
                                      child: SizedBox(
                                        width: 300,
                                        height: 150,
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Flexible(child:Text(
                                                (widget.room.rounds[i].lots[j].winner?.username ?? ""),
                                                  style: Theme.of(context).textTheme.headlineSmall,
                                                )),
                              Flexible(child:Text(
                                                  " ("+(widget.room.rounds[i].lots[j].winner?.sum ?? 0).toString() +")",
                                                  style: Theme.of(context).textTheme.headlineSmall,
                                                ),),
                                                Padding(
                                                    padding: EdgeInsets.only(left: 5),
                                                  child: Icon(
                                                      (widget.room.rounds[i].lots[j].winner?.username ?? "") == user?
                                                        Icons.check:Icons.close,
                                                    color: (widget.room.rounds[i].lots[j].winner?.username ?? "") == user?
                                                    Colors.green:Colors.red,
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ]),
                  ),
                );
              }),
        ));
  }

  bool isActive(int i, int j, int intervalId) {
    return isLogged && bets[intervalId]==null;
  }


  @override
  void dispose() {
    super.dispose();
    //presenter.dispose();
  }

  @override
  void initState() {
    super.initState();
    presenter.setView(this);
    presenter.setRoom(widget.room);
    isAdmin = widget.room.creator.username==getIt<TokenService>().getUser().username;

    User thisUser = getIt<TokenService>().getUser();
    isLogged = widget.room.connectedUsers.map((e) => e.username).contains(thisUser.username);

  }

  @override
  void updateBet(int intervalId, int? bet) {
    setState(() {
      bets[intervalId] = bet;
    });
  }

  @override
  void updateLotStatus(int i, int j, Status status) {
    setState(() {
      widget.room.rounds[i].lots[j].status = status;
    });
  }

  @override
  void updateLotWinner(int i, int j, ParticipantBet? bet) {
    if(bet==null){
      return;
    }
    setState(() {
      widget.room.rounds[i].lots[j].winner = bet;
    });
  }

  @override
  void updateRoundStatus(int i, Status status) {
    setState(() {
      widget.room.rounds[i].status = status;
    });
  }

  @override
  void updateRoomStatus(Status status) {
    setState(() {
      widget.room.status = status;
    });
  }

  @override
  void showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(error)));
  }
}
