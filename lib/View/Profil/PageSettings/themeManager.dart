import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../../Widgets/PatternPages/pageSettingsDefault.dart';

class ThemeManager extends StatefulWidget {
  @override
  _ThemeState createState() => _ThemeState();
}

class _ThemeState extends State<ThemeManager> {
  //String get name => null;


  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
        name: 'Theme Page',
        child: Center(
          child: Text('pas de contenue pour l\'instant'),
        )


    );
  }
}