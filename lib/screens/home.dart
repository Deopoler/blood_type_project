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
                      title: const Text("RH+"),
                      value: RH.positive,
                      groupValue: rh,
                      onChanged: (RH? value) {
                        setState(() {
                          rh = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("RH-"),
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
                          "Rh응집원 ${rh == RH.positive ? '있음' : '없음'}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Rh응집소 없음${rh == RH.positive ? '' : '(후천적 생성 가능)'}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (abo == ABO.A)
                          Text(
                            "응집원 A 있음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.B)
                          Text(
                            "응집원 B 있음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.AB)
                          Text(
                            "응집원 A와 B 있음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.O)
                          Text(
                            "응집원 A와 B 없음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.A)
                          Text(
                            "응집소 β 있음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.B)
                          Text(
                            "응집원 α 있음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.AB)
                          Text(
                            "응집원 α와 β 없음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (abo == ABO.O)
                          Text(
                            "응집원 α와 β 있음",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                      ],
                    ),
                    const Divider(),
                    buildResponse(
                        context: context,
                        responseName: "Rh 반응",
                        result: rh == RH.positive),
                    buildResponse(
                        context: context,
                        responseName: "항A혈청 반응",
                        result: abo == ABO.A || abo == ABO.AB),
                    buildResponse(
                        context: context,
                        responseName: "항B혈청 반응",
                        result: abo == ABO.B || abo == ABO.AB),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          "수혈 받기 가능",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(다량 수혈) ",
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
                                    "(소량 수혈) ",
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
                          "수혈 제공 가능",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(다량 수혈) ",
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
                                    "(소량 수혈) ",
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
                  result ? "응집반응 일어남" : "응집반응 없음",
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
        '혈액형',
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
