import 'package:flutter/material.dart';

import '../../../Widgets/PatternPages/pageSettingsDefault.dart';

class NotificationManager extends StatefulWidget {
  @override
  _NotificationManagerState createState() => _NotificationManagerState();
}

class _NotificationManagerState extends State<NotificationManager> {
  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
        name: 'Notification Page',
        child: Center(
          child: Text('pas de contenue pour l\'instant'),
        )


    );
  }
}