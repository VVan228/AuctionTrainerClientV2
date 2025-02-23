import 'package:auction_trainer_client_v2/security/model/BetParams.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateData.dart';
import 'package:auction_trainer_client_v2/security/model/TemplateRound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateTemplatePage extends StatefulWidget {
  const CreateTemplatePage(
      {Key? key, required this.templateData, required this.viewMode})
      : super(key: key);

  final TemplateData templateData;
  final bool viewMode;

  @override
  State<CreateTemplatePage> createState() => _CreateTemplatePageState();
}

class _CreateTemplatePageState extends State<CreateTemplatePage> {
  var templateNameController = TextEditingController();
  var durationController = TextEditingController();
  var lotPauseController = TextEditingController();
  var roundPauseController = TextEditingController();
  var limitSumController = TextEditingController();
  var startSumController = TextEditingController();
  List<String> lotNames = [];
  List<String> lotDescriptions = [];
  List<TemplateRound> rounds = [];
  bool manualMode = true;
  List<bool> manualModeWhat = [true, false];

  void setManualMode(bool mode) {
    if (mode) {
      setState(() {
        manualMode = true;
        manualModeWhat[0] = true;
        manualModeWhat[1] = false;
      });
    } else {
      setState(() {
        manualMode = false;
        manualModeWhat[1] = true;
        manualModeWhat[0] = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    rounds = widget.templateData.rounds;
    lotNames = widget.templateData.lotNames;
    lotDescriptions = widget.templateData.lotDescriptions;
    templateNameController =
        TextEditingController(text: widget.templateData.templateName);
    durationController = TextEditingController(
        text: widget.templateData.lotDuration != null
            ? "${widget.templateData.lotDuration}"
            : null);
    lotPauseController = TextEditingController(
        text: widget.templateData.lotPauseDuration != null
            ? "${widget.templateData.lotPauseDuration}"
            : null);
    roundPauseController = TextEditingController(
        text: widget.templateData.roundPauseDuration != null
            ? "${widget.templateData.roundPauseDuration}"
            : null);
    if (widget.templateData.betParams != null) {
      limitSumController = TextEditingController(
          text: widget.templateData.betParams?.limitSum != null
              ? "${widget.templateData.betParams?.limitSum}"
              : "");
      startSumController = TextEditingController(
          text: widget.templateData.betParams?.startSum != null
              ? "${widget.templateData.betParams?.startSum}"
              : "");
    } else {
      limitSumController = TextEditingController();
      startSumController = TextEditingController();
    }
    setManualMode(widget.templateData.manualMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("CreateTemplate"),
        ),
        floatingActionButton: Visibility(
          visible: !widget.viewMode,
          child: FloatingActionButton.extended(
              onPressed: () {
                widget.templateData.rounds = rounds;
                widget.templateData.lotNames = lotNames;
                widget.templateData.lotDescriptions = lotDescriptions;

                widget.templateData.templateName = templateNameController.text;
                widget.templateData.manualMode = manualMode;
                widget.templateData.lotDuration =
                    int.tryParse(durationController.text);
                widget.templateData.lotPauseDuration =
                    int.tryParse(lotPauseController.text);
                widget.templateData.roundPauseDuration =
                    int.tryParse(roundPauseController.text);
                if ((limitSumController.text.isNotEmpty) ||
                    (startSumController.text.isNotEmpty)) {
                  widget.templateData.betParams ??= BetParams(
                    minBetStep: 1,
                    limitSum: int.tryParse(limitSumController.text),
                    startSum: int.tryParse(startSumController.text),
                  );
                }
                Navigator.pop(context, widget.templateData);
              },
              label: const Icon(Icons.save_alt)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                enabled: !widget.viewMode,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                controller: templateNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "lot duration",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 1,
                      fit: FlexFit.tight),
                  Flexible(
                      child: TextFormField(
                        enabled: !widget.viewMode,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: durationController,
                      ),
                      flex: 1,
                      fit: FlexFit.tight)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "lot pause duration",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 1,
                      fit: FlexFit.tight),
                  Flexible(
                      child: TextFormField(
                        enabled: !widget.viewMode,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: lotPauseController,
                      ),
                      flex: 1,
                      fit: FlexFit.tight)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "round pause duration",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 1,
                      fit: FlexFit.tight),
                  Flexible(
                      child: TextFormField(
                        enabled: !widget.viewMode,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: roundPauseController,
                      ),
                      flex: 1,
                      fit: FlexFit.tight)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "start sum",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 1,
                      fit: FlexFit.tight),
                  Flexible(
                      child: TextFormField(
                        enabled: !widget.viewMode,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: startSumController,
                      ),
                      flex: 1,
                      fit: FlexFit.tight)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "limit sum",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 1,
                      fit: FlexFit.tight),
                  Flexible(
                      child: TextFormField(
                        enabled: !widget.viewMode,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: limitSumController,
                      ),
                      flex: 1,
                      fit: FlexFit.tight)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Text(
                    "rounds",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 25, minHeight: 25),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: rounds.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int i) {
                          if (i == rounds.length) {
                            return RawMaterialButton(
                              onPressed: widget.viewMode
                                  ? null
                                  : () async {
                                      var res = await showDialog<TemplateRound>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CreateRoundDialog(
                                                viewMode: widget.viewMode,
                                                round: TemplateRound(
                                                    ascending: true),
                                                index: rounds.length + 1,
                                              ));
                                      if (res != null) {
                                        setState(() {
                                          rounds.add(res);
                                        });
                                      }
                                    },
                              //elevation: 2.0,
                              fillColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme
                                  ?.primary,
                              child: const Icon(
                                Icons.add,
                                size: 25.0,
                                color: Colors.black,
                              ),
                              padding: const EdgeInsets.all(0),
                              shape: const CircleBorder(),
                            );
                          }
                          // return IconButton(onPressed: () async {
                          //   var res = await showDialog<TemplateRound>(
                          //       context: context,
                          //       builder: (BuildContext context) => CreateRoundDialog(round: rounds[i], index: i,)
                          //   );
                          //   if(res != null) {
                          //     setState(() {
                          //       rounds[i] = res;
                          //     });
                          //   }
                          // }, icon: Container(
                          //
                          //     child:Icon(rounds[i].ascending? Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp)));
                          return RawMaterialButton(
                            onPressed: () async {
                              var res = await showDialog<TemplateRound>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CreateRoundDialog(
                                        viewMode: widget.viewMode,
                                        round: rounds[i],
                                        index: i,
                                      ));
                              if (res != null) {
                                setState(() {
                                  rounds[i] = res;
                                });
                              }
                            },
                            //elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              rounds[i].ascending
                                  ? Icons.keyboard_arrow_up_sharp
                                  : Icons.keyboard_arrow_down_sharp,
                              size: 25.0,
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.all(0),
                            shape: const CircleBorder(),
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "lot names",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 5,
                      fit: FlexFit.tight),
                  Flexible(
                      child: PopupMenuButton(
                          initialValue: null,
                          onSelected: null,
                          tooltip: "names",
                          itemBuilder: (BuildContext context) {
                            return lotNames.map((e) {
                              return PopupMenuItem<String>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e),
                                    IconButton(
                                        onPressed: widget.viewMode
                                            ? null
                                            : () {
                                                setState(() {
                                                  lotNames.remove(e);
                                                });
                                                Navigator.pop(context);
                                              },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              );
                            }).toList();
                          }),
                      flex: 4,
                      fit: FlexFit.tight),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: RawMaterialButton(
                            onPressed: widget.viewMode
                                ? null
                                : () async {
                                    var res = await showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const GetTextDialog(field: "name"));
                                    if (res != null &&
                                        res.isNotEmpty &&
                                        !lotNames.contains(res)) {
                                      setState(() {
                                        lotNames.add(res);
                                      });
                                    }
                                  },
                            //elevation: 2.0,
                            fillColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme
                                ?.primary,
                            child: const Icon(
                              Icons.add,
                              size: 25.0,
                              color: Colors.black,
                            ),
                            //padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                          ))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                        "lot desc's",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      flex: 5,
                      fit: FlexFit.tight),
                  Flexible(
                      child: PopupMenuButton(
                          initialValue: null,
                          onSelected: null,
                          tooltip: "descriptions",
                          itemBuilder: (BuildContext context) {
                            return lotDescriptions.map((e) {
                              return PopupMenuItem<String>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e),
                                    IconButton(
                                        onPressed: widget.viewMode
                                            ? null
                                            : () {
                                                setState(() {
                                                  lotDescriptions.remove(e);
                                                });
                                                Navigator.pop(context);
                                              },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              );
                            }).toList();
                          }),
                      flex: 4,
                      fit: FlexFit.tight),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: RawMaterialButton(
                            onPressed: widget.viewMode
                                ? null
                                : () async {
                                    var res = await showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const GetTextDialog(
                                                field: "description"));
                                    if (res != null &&
                                        res.isNotEmpty &&
                                        !lotDescriptions.contains(res)) {
                                      setState(() {
                                        lotDescriptions.add(res);
                                      });
                                    }
                                  },
                            //elevation: 2.0,
                            fillColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme
                                ?.primary,
                            child: const Icon(
                              Icons.add,
                              size: 25.0,
                              color: Colors.black,
                            ),
                            //padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                          ))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  isSelected: manualModeWhat,
                  children: const [
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 5),
                        child: Text("Manual mode")),
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 10),
                        child: Text("Auto mode")),
                  ],
                  selectedColor: Theme.of(context).primaryColorDark,
                  borderColor: Theme.of(context).scaffoldBackgroundColor,
                  selectedBorderColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  onPressed: widget.viewMode
                      ? (int i) {}
                      : (int i) {
                          if (i == 0) {
                            setManualMode(true);
                          } else {
                            setManualMode(false);
                          }
                        },
                ),
              ),
            ],
          ),
        ));
  }
}

class GetTextDialog extends StatefulWidget {
  const GetTextDialog({Key? key, required this.field}) : super(key: key);

  final String field;

  @override
  State<GetTextDialog> createState() => _GetTextDialogState();
}

class _GetTextDialogState extends State<GetTextDialog> {
  var fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                "Enter ${widget.field}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text(widget.field),
                ),
                controller: fieldController,
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
                    Navigator.pop(context, fieldController.text);
                  },
                  child: const Text('Ok'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CreateRoundDialog extends StatefulWidget {
  const CreateRoundDialog(
      {Key? key,
      required this.round,
      required this.index,
      required this.viewMode})
      : super(key: key);

  final TemplateRound round;
  final int index;
  final bool viewMode;

  @override
  State<CreateRoundDialog> createState() => _CreateRoundDialogState();
}

class _CreateRoundDialogState extends State<CreateRoundDialog> {
  TextEditingController? durationController;
  TextEditingController? lotPauseController;
  TextEditingController? roundPauseController;
  TextEditingController? limitSumController;
  TextEditingController? startSumController;

  List<Icon> ascendingIcons = [
    const Icon(Icons.keyboard_arrow_up_sharp),
    const Icon(Icons.keyboard_arrow_down_sharp)
  ];
  List<bool> ascendingWhat = [true, false];

  bool ascending = true;

  void setAscending(bool asc) {
    if (asc) {
      setState(() {
        ascending = asc;
        ascendingWhat[1] = false;
        ascendingWhat[0] = true;
      });
    } else {
      setState(() {
        ascending = asc;
        ascendingWhat[1] = true;
        ascendingWhat[0] = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    durationController = TextEditingController(
        text: widget.round.lotDuration != null
            ? "${widget.round.lotDuration}"
            : null);
    lotPauseController = TextEditingController(
        text: widget.round.lotPauseDuration != null
            ? "${widget.round.lotPauseDuration}"
            : null);
    roundPauseController = TextEditingController(
        text: widget.round.roundPauseDuration != null
            ? "${widget.round.roundPauseDuration}"
            : null);
    if (widget.round.betParams != null) {
      limitSumController = TextEditingController(
          text: widget.round.betParams?.limitSum != null
              ? "${widget.round.betParams?.limitSum}"
              : "");
      startSumController = TextEditingController(
          text: widget.round.betParams?.startSum != null
              ? "${widget.round.betParams?.startSum}"
              : "");
    } else {
      limitSumController = TextEditingController();
      startSumController = TextEditingController();
    }
    setAscending(widget.round.ascending);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    "Configure round ${widget.index + 1}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    enabled: !widget.viewMode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(label: Text("lot duration")),
                    controller: durationController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    enabled: !widget.viewMode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(label: Text("lot pause")),
                    controller: lotPauseController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    enabled: !widget.viewMode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(label: Text("round pause")),
                    controller: roundPauseController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    enabled: !widget.viewMode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(label: Text("start sum")),
                    controller: startSumController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    enabled: !widget.viewMode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(label: Text("limit sum")),
                    controller: limitSumController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: ToggleButtons(
                    direction: Axis.horizontal,
                    isSelected: ascendingWhat,
                    children: ascendingIcons,
                    selectedColor: Theme.of(context).primaryColorDark,
                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                    selectedBorderColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    onPressed: widget.viewMode
                        ? (int i) {}
                        : (int i) {
                            if (i == 0) {
                              setAscending(true);
                            } else {
                              setAscending(false);
                            }
                          },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      child: const Text('Close'),
                    ),
                    TextButton(
                      onPressed: widget.viewMode
                          ? null
                          : () {
                              widget.round.ascending = ascending;
                              widget.round.lotDuration =
                                  int.tryParse(durationController?.text ?? "");
                              widget.round.lotPauseDuration =
                                  int.tryParse(lotPauseController?.text ?? "");
                              widget.round.roundPauseDuration = int.tryParse(
                                  roundPauseController?.text ?? "");
                              if ((limitSumController != null &&
                                      limitSumController!.text.isNotEmpty) ||
                                  (startSumController != null &&
                                      startSumController!.text.isNotEmpty)) {
                                widget.round.betParams = BetParams(
                                  minBetStep: 1,
                                  limitSum: int.tryParse(
                                      limitSumController?.text ?? ""),
                                  startSum: int.tryParse(
                                      startSumController?.text ?? ""),
                                );
                              }
                              Navigator.pop(context, widget.round);
                            },
                      child: const Text('Ok'),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
