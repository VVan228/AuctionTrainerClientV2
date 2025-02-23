import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/create_room/api/CreateRoomPresenter.dart';
import 'package:auction_trainer_client_v2/pages/create_room/api/CreateRoomView.dart';
import 'package:auction_trainer_client_v2/pages/create_template/CreateTemplatePage.dart';
import 'package:auction_trainer_client_v2/security/model/CreateRoomRequest.dart';
import 'package:auction_trainer_client_v2/security/model/Lot.dart';
import 'package:auction_trainer_client_v2/security/model/LotRequest.dart';
import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CreateLotsPage.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({Key? key, required this.template}) : super(key: key);

  final Template template;

  @override
  State<CreateRoomPage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateRoomPage> implements CreateRoomView {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<List<LotRequest>> roundLots = [];
  bool withTime = true;

  var roomNameController = TextEditingController();

  CreateRoomPresenter presenter = getIt<CreateRoomPresenter>();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.template.data.rounds.length; i++) {
      roundLots.add([]);
    }
    presenter.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create room"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          presenter.createRoomClick(CreateRoomRequest(
              name: roomNameController.text,
              startTime: withTime
                  ? DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, selectedTime.hour, selectedTime.minute)
                  : null,
              templateId: widget.template.id,
              lots: roundLots));
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Room name"),
                ),
                controller: roomNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Template: ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateTemplatePage(
                                    templateData: widget.template.data,
                                    viewMode: true)));
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    widget.template.data.templateName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Date and time: ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          var res = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: selectedDate,
                              lastDate:
                                  selectedDate.add(const Duration(days: 7)));
                          if (res != null) {
                            setState(() {
                              selectedDate = res;
                            });
                          }
                        },
                        child: Text(
                          "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}",
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () async {
                          var res = await showTimePicker(
                              context: context, initialTime: selectedTime);
                          if (res != null) {
                            setState(() {
                              selectedTime = res;
                            });
                          }
                        },
                        child: Text(
                          "${selectedTime.hour}:${selectedTime.minute}",
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                    Checkbox(
                        value: withTime,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              withTime = value;
                            });
                          }
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Rounds: ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.template.data.rounds.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () async {
                              var res = await Navigator.push<List<LotRequest>>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateLotsPage(
                                          lots: roundLots[i].isEmpty
                                              ? []
                                              : roundLots[i],
                                          template: widget.template,
                                          roundIndex: i)));
                              if (res != null) {
                                roundLots[i] = res;
                                print(res.toString());
                              }
                              return;
                            },
                            child: Text(
                              "round ${i + 1}",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          widget.template.data.rounds[i].ascending
                              ? const Icon(
                                  Icons.keyboard_arrow_up_sharp,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                )
                        ],
                      );
                    }),
              )
            ]),
      ),
    );
  }

  @override
  void openMainPage() {
    print("created");
  }

  @override
  void showError(String err) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
  }
}
