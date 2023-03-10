import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum RH { positive, negative }

enum ABO { A, B, AB, O }

class _HomeState extends State<Home> {
  var rh = RH.positive;
  var abo = ABO.A;
  var selectedABO = false;

  var canReceive = {
    ABO.A: [
      ABO.O,
    ],
    ABO.B: [
      ABO.O,
    ],
    ABO.AB: [
      ABO.A,
      ABO.B,
      ABO.O,
    ],
    ABO.O: []
  };

  var canGive = {
    ABO.A: [
      ABO.AB,
    ],
    ABO.B: [
      ABO.AB,
    ],
    ABO.AB: [],
    ABO.O: [
      ABO.A,
      ABO.B,
      ABO.O,
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: buildAppBar(context),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(
            width: 1100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                child: Column(
                  children: [
                    RadioListTile(
                      title: const Text("Rh+"),
                      value: RH.positive,
                      groupValue: rh,
                      onChanged: (RH? value) {
                        setState(() {
                          rh = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("Rh-"),
                      value: RH.negative,
                      groupValue: rh,
                      onChanged: (RH? value) {
                        setState(() {
                          rh = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              CustomCard(
                child: Column(
                  children: [
                    RadioListTile(
                      title: const Text("A"),
                      value: ABO.A,
                      groupValue: abo,
                      onChanged: onABOChanged,
                    ),
                    RadioListTile(
                      title: const Text("B"),
                      value: ABO.B,
                      groupValue: abo,
                      onChanged: onABOChanged,
                    ),
                    RadioListTile(
                      title: const Text("AB"),
                      value: ABO.AB,
                      groupValue: abo,
                      onChanged: onABOChanged,
                    ),
                    RadioListTile(
                      title: const Text("O"),
                      value: ABO.O,
                      groupValue: abo,
                      onChanged: onABOChanged,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onABOChanged(ABO? value) {
    setState(() {
      abo = value!;
      selectedABO = true;
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              constraints: const BoxConstraints.expand(
                width: 1100,
              ),
              padding: const EdgeInsets.only(top: 50),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context)
                    .copyWith(scrollbars: false, overscroll: false),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "Rh${rh == RH.positive ? '+' : '-'}${describeEnum(abo).toUpperCase()}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Rh????????? ${rh == RH.positive ? '??????' : '??????'}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Rh????????? ??????${rh == RH.positive ? '' : '(????????? ?????? ??????)'}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (abo == ABO.A)
                          Text(
                            "????????? A ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.B)
                          Text(
                            "????????? B ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.AB)
                          Text(
                            "????????? A??? B ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.O)
                          Text(
                            "????????? A??? B ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.A)
                          Text(
                            "????????? ?? ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.B)
                          Text(
                            "????????? ?? ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.AB)
                          Text(
                            "????????? ????? ?? ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.O)
                          Text(
                            "????????? ????? ?? ??????",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                      ],
                    ),
                    const Divider(),
                    buildResponse(
                        context: context,
                        responseName: "Rh ??????",
                        result: rh == RH.positive),
                    buildResponse(
                        context: context,
                        responseName: "???A?????? ??????",
                        result: abo == ABO.A || abo == ABO.AB),
                    buildResponse(
                        context: context,
                        responseName: "???B?????? ??????",
                        result: abo == ABO.B || abo == ABO.AB),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          "?????? ?????? ??????",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(?????? ??????) ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "Rh${rh == RH.positive ? '+' : '-'}${describeEnum(abo).toUpperCase()} ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(?????? ??????) ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  for (var bloodType in canReceive[abo]!)
                                    Text(
                                      "Rh${rh == RH.positive ? '+' : '-'}${describeEnum(bloodType).toUpperCase()} ",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  if (rh == RH.positive)
                                    Text(
                                      "Rh-${describeEnum(abo).toUpperCase()} ",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  if (rh == RH.positive)
                                    for (var bloodType in canReceive[abo]!)
                                      Text(
                                        "Rh-${describeEnum(bloodType).toUpperCase()} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          "?????? ?????? ??????",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(?????? ??????) ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "Rh${rh == RH.positive ? '+' : '-'}${describeEnum(abo).toUpperCase()} ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(?????? ??????) ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  for (var bloodType in canGive[abo]!)
                                    Text(
                                      "Rh${rh == RH.positive ? '+' : '-'}${describeEnum(bloodType).toUpperCase()} ",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  if (rh == RH.negative)
                                    Text(
                                      "Rh+${describeEnum(abo).toUpperCase()} ",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  if (rh == RH.negative)
                                    for (var bloodType in canGive[abo]!)
                                      Text(
                                        "Rh+${describeEnum(bloodType).toUpperCase()} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Container buildResponse({
    required BuildContext context,
    required String responseName,
    required bool result,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Image.asset(
            result
                ? 'assets/images/positive.bmp'
                : 'assets/images/negative.bmp',
            width: 100,
            height: 100,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  responseName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  result ? "???????????? ?????????" : "???????????? ??????",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: Text(
        '?????????',
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget? child;
  const CustomCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
