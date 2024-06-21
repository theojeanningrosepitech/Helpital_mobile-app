import 'dart:async';
import 'package:flutter/material.dart';

class MySuccessPage extends StatefulWidget {
  const MySuccessPage({Key key}) : super(key: key);

  @override
  _MySuccessPageState createState() => _MySuccessPageState();
}

class _MySuccessPageState extends State<MySuccessPage> {

  final Stream<int> counter = (() {
    StreamController<int> controller;
    controller = StreamController<int>(
      onListen: () async {
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(3);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(2);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(1);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(0);
      },
    );
    return controller.stream;
  })();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text('Votre note a été réalisée avec succès'),
              Image.asset(
                "assets/RobotHelpital.gif",
                height: 300.0,
                width: 300.0,

              ),
              StreamBuilder(
                  stream: counter,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    List<Widget> children = <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('4'),
                      )
                    ];
                    if (snapshot.hasError) {
                      children = children = <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('4'),
                        )
                      ];
                    } else {
                      if (snapshot.connectionState == ConnectionState.active) {
                          children = <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('${snapshot.data}'),
                            )
                          ];

                      }
                    }
                    if (snapshot.data == 0) {
                      Navigator.pop(context);
                    }
                    return Column(children: children,);

                  }
              )
            ],
          ),
        )
      ),
    );
  }
}
