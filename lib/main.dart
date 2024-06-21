import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/stateManagerConnection.dart';
import 'package:helpital_mobile_app/Services/stateManager.dart';
import 'package:helpital_mobile_app/Services/stateManagerTypeOfUser.dart';
import 'package:helpital_mobile_app/wrapper.dart';
import 'package:provider/provider.dart';

import 'Services/stateManagerPatient.dart';


void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => StateManager()),
            ChangeNotifierProvider(create: (_) => StateManagerConnection()),
            ChangeNotifierProvider(create: (_) => StateManagerTypeOfUser()),
            ChangeNotifierProvider(create: (_) => StateManagerPatient()),
          ],
          child: MyApp()
      )
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
            }),
          ),
          debugShowCheckedModeBanner: false,
          // home: SliderAnimated(),
          home: Wrapper(),
    );

  }
}