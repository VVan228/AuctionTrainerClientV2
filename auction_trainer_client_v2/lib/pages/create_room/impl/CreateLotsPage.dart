import 'package:auction_trainer_client_v2/security/model/BetParams.dart';
import 'package:auction_trainer_client_v2/security/model/Lot.dart';
import 'package:auction_trainer_client_v2/security/model/LotRequest.dart';
import 'package:auction_trainer_client_v2/security/model/Template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateLotsPage extends StatefulWidget {
  const CreateLotsPage(
      {Key? key,
      required this.template,
      required this.roundIndex,
      required this.lots})
      : super(key: key);

  final Template template;
  final List<LotRequest> lots;
  final int roundIndex;

  @override
  State<CreateLotsPage> createState() => _CreateLotsPageState();
}

class _CreateLotsPageState extends State<CreateLotsPage> {
  List<TextEditingController> limitSumControl = [];
  List<TextEditingController> startSumControl = [];

  List<TextEditingController> nameControl = [];
  List<GlobalKey> nameKeys = [];
  List<FocusNode> nameFocus = [];

  List<TextEditingController> descControl = [];
  List<GlobalKey> descKeys = [];
  List<FocusNode> descFocus = [];

  int defaultStartSum = 0;
  int defaultLimitSum = 0;

  @override
  void initState() {
    super.initState();
    if (widget.template.data.betParams != null &&
        widget.template.data.betParams!.startSum != null) {
      defaultStartSum = widget.template.data.betParams!.startSum!;
    }
    if (widget.template.data.betParams != null &&
        widget.template.data.betParams!.limitSum != null) {
      defaultLimitSum = widget.template.data.betParams!.limitSum!;
    }

    if (widget.template.data.rounds[widget.roundIndex].betParams != null &&
        widget.template.data.rounds[widget.roundIndex].betParams!.startSum !=
            null) {
      defaultStartSum =
          widget.template.data.rounds[widget.roundIndex].betParams!.startSum!;
    }
    if (widget.template.data.rounds[widget.roundIndex].betParams != null &&
        widget.template.data.rounds[widget.roundIndex].betParams!.limitSum !=
            null) {
      defaultLimitSum =
          widget.template.data.rounds[widget.roundIndex].betParams!.limitSum!;
    }
    for (LotRequest lr in widget.lots) {
      addLotInfo(lr.name, lr.description);
    }
  }

  void addLotInfo(String? name, String? desc) {
    nameControl.add(TextEditingController(text: name ?? ""));
    nameKeys.add(GlobalKey());
    nameFocus.add(FocusNode());

    descControl.add(TextEditingController(text: desc ?? ""));
    descKeys.add(GlobalKey());
    descFocus.add(FocusNode());

    startSumControl.add(TextEditingController(text: "$defaultStartSum"));
    limitSumControl.add(TextEditingController(text: "$defaultLimitSum"));
  }

  void deleteLot(int i) {
    widget.lots.removeAt(i);

    nameControl.removeAt(i);
    nameKeys.removeAt(i);
    nameFocus.removeAt(i);

    descControl.removeAt(i);
    descKeys.removeAt(i);
    descFocus.removeAt(i);

    startSumControl.removeAt(i);
    limitSumControl.removeAt(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure lots"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              for (var name in nameControl) {
                if (name.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Some names are empty")));
                  return;
                }
              }
              for (var desc in descControl) {
                if (desc.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Some descriptions are empty")));
                  return;
                }
              }
              Navigator.pop(context, widget.lots);
            },
            child: const Icon(Icons.done),
            heroTag: null,
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                //lots.add(Lot(status: Status, duration: duration, autoend: autoend, intervalId: intervalId, name: name, description: description, betParams: betParams))
                widget.lots.add(LotRequest(
                    duration: null,
                    name: "",
                    description: "",
                    betParams: null));

                addLotInfo(null, null);
              });
            },
            child: const Icon(Icons.add),
            heroTag: null,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.lots.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctxt, int i) {
              return Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          deleteLot(i);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                  TextFormField(
                    onChanged: (text) {
                      widget.lots[i].name = text;
                    },
                    controller: nameControl[i],
                    focusNode: nameFocus[i],
                    decoration: const InputDecoration(
                      hintText: 'Lot name',
                    ),
                    onFieldSubmitted: (String value) {
                      RawAutocomplete.onFieldSubmitted<String>(nameKeys[i]);
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RawAutocomplete<String>(
                      onSelected: (text) {
                        widget.lots[i].name = text;
                      },
                      key: nameKeys[i],
                      focusNode: nameFocus[i],
                      textEditingController: nameControl[i],
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return widget.template.data.lotNames
                            .where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        }).toList();
                      },
                      optionsViewBuilder: (
                        BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options,
                      ) {
                        return Material(
                          elevation: 4.0,
                          child: ListView(
                            children: options
                                .map((String option) => GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  TextFormField(
                    onChanged: (text) {
                      widget.lots[i].description = text;
                    },
                    controller: descControl[i],
                    focusNode: descFocus[i],
                    decoration: const InputDecoration(
                      hintText: 'Lot description',
                    ),
                    onFieldSubmitted: (String value) {
                      RawAutocomplete.onFieldSubmitted<String>(descKeys[i]);
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RawAutocomplete<String>(
                      onSelected: (text) {
                        widget.lots[i].description = text;
                      },
                      key: descKeys[i],
                      focusNode: descFocus[i],
                      textEditingController: descControl[i],
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return widget.template.data.lotDescriptions
                            .where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        }).toList();
                      },
                      optionsViewBuilder: (
                        BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options,
                      ) {
                        return Material(
                          elevation: 4.0,
                          child: ListView(
                            children: options
                                .map((String option) => GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: startSumControl[i],
                          decoration: const InputDecoration(
                            label: Text("start sum"),
                          ),
                          onChanged: (text) {
                            if (widget.lots[i].betParams == null) {
                              widget.lots[i].betParams = BetParams(
                                  startSum: int.parse(text),
                                  limitSum: null,
                                  minBetStep: null);
                              return;
                            }
                            widget.lots[i].betParams!.startSum =
                                int.parse(text);
                          },
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            if (widget.lots[i].betParams == null) {
                              widget.lots[i].betParams = BetParams(
                                  startSum: null,
                                  limitSum: int.parse(text),
                                  minBetStep: null);
                              return;
                            }
                            widget.lots[i].betParams!.limitSum =
                                int.parse(text);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: limitSumControl[i],
                          decoration: const InputDecoration(
                            label: Text("limit sum"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            }),
      ),
    );
  }
}
