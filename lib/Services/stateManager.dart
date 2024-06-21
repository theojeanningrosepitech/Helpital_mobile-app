import 'package:flutter/foundation.dart';

class StateManager with ChangeNotifier, DiagnosticableTreeMixin {
  bool _state = false;

  bool get state => _state;

  void disconnect() {
    _state = false;
    notifyListeners();
  }
  void connect() {
    _state = true;
    notifyListeners();
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('state', 1));
  }
}