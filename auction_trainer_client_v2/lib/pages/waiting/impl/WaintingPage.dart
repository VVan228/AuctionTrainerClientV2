import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/auction/impl/AuctionPage.dart';
import 'package:auction_trainer_client_v2/pages/waiting/api/WaitingPresenter.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';

import '../api/WaitingView.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key, required this.room}) : super(key: key);

  final Room room;

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> implements WaitingView{
  bool isJoined = false;

  List<String> peopleWatching = [];
  List<String> joinedUsers = [];
  WaitingPresenter presenter = getIt<WaitingPresenter>();
  String myname = getIt<TokenService>().getUser().username;
  String clock = "00:00";
  CountdownTimerController? controller;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
              child: FloatingActionButton.large(
                child: Icon(isJoined?Icons.exposure_minus_1:Icons.plus_one),
                onPressed: (){
                  if(isJoined) {
                    presenter.leaveClick();
                  }else {
                    presenter.joinClick();
                  }
                },
                heroTag: null,
              ),
            visible: !isAdmin,
          ),
          Visibility(
              child: FloatingActionButton.large(
                child: Icon(Icons.send),
                onPressed: (){
                  presenter.sendNextPoint();
                },
                heroTag: null,
              ),
            visible: isAdmin,
          )
        ],
      ),
        body: Column(
      children: [
        Expanded(
          flex: 30,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Row(
                children:
                [
                  const Center(child:
                  SizedBox( width: 50, height: 50, child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ))),

                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: CountdownTimer(
                      controller: controller,
                      textStyle: Theme.of(context).textTheme.displayMedium,
                    )//Text(clock, style: Theme.of(context).textTheme.displayLarge,)
                    ,)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:55, bottom: 5),
              child: Text("Joined users:", style: Theme.of(context).textTheme.headlineSmall,),),
          ],
        ),
        Expanded(
          flex: 20,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                border: Border.all(color: Colors.white)),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ListView.builder
                (
                  itemCount: joinedUsers.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Text(joinedUsers[index]);
                  }
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:20, left:55),
              child: Text("People watching:", style: Theme.of(context).textTheme.headlineSmall,),
            ),
          ],
        ),
        Expanded(
          flex: 50,
          child: Padding(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).primaryColorLight,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                splashColor: Theme.of(context).primaryColorLight.withAlpha(30),
                onTap: (){},
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: ListView.builder
                    (
                      itemCount: peopleWatching.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Text(peopleWatching[index]);
                      }
                  ),
                ),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 50, left: 50, right: 50),
          )
        ),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    //presenter.dispose();
  }

  @override
  void initState() {
    super.initState();
    presenter.setView(this);
    presenter.setRoom(widget.room);
    isAdmin = widget.room.creator.username==getIt<TokenService>().getUser().username;
  }

  @override
  void addParticipant(String user) {
    if(!joinedUsers.contains(user)){
      setState(() {
        joinedUsers.add(user);
      });
    }
    if(user == myname){
      setState(() {
        isJoined = true;
      });
    }
  }

  @override
  void addWatcher(String username) {
    if(!peopleWatching.contains(username)) {
      setState(() {
        peopleWatching.add(username);
      });
    }
  }

  @override
  void openRoom(Room room) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuctionPage(room: room)),
    );
  }

  @override
  void removeParticipant(String user) {
    if(joinedUsers.contains(user)) {
      setState(() {
        joinedUsers.remove(user);
      });
    }
    if(user == myname){
      setState(() {
        isJoined = false;
      });
    }
  }

  @override
  void removeWatcher(String username) {
    if(peopleWatching.contains(username)) {
      setState(() {
        peopleWatching.remove(username);
      });
    }
  }

  @override
  void setClock(int time) {
    setState(() {
      controller = CountdownTimerController(endTime: time);
    });
  }
}
