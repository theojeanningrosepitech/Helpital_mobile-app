import 'package:flutter/material.dart';

import '../../../Widgets/PatternPages/pageSettingsDefault.dart';

class Assistance extends StatefulWidget {
  @override
  _AssistanceState createState() => _AssistanceState();
}

class _AssistanceState extends State<Assistance> {
  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
        name: 'Assistance Page',
        child: Center(
          child: Text('pas de contenue pour l\'instant'),
        )


    );
  }
}
