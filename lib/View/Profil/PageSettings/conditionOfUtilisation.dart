import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Widgets/PatternPages/pageSettingsDefault.dart';

class ConditionOfUtilisation extends StatefulWidget {
  @override
  _ConditionOfUtilisationState createState() => _ConditionOfUtilisationState();
}

class _ConditionOfUtilisationState extends State<ConditionOfUtilisation> {
  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
      name: 'Condition d\'utilisation',
      child: Center(child: Text('test'),),
    );
  }
}