import 'package:flutter/foundation.dart';

import '../Models/Utils/ConnectionParameters.dart';
import 'auth.dart';

class StateManagerConnection with ChangeNotifier, DiagnosticableTreeMixin {
  bool _state = false;
  TypePreferedSendingMethod _typePreferedSendingMethod = TypePreferedSendingMethod.ErrorConnection;

  bool get state => _state;
  TypePreferedSendingMethod get typePreferedSendingMethod => _typePreferedSendingMethod;

  void setParameters(ConnectionParameters _params) {
    _typePreferedSendingMethod = _params.typePreferedSendingMethod;
    notifyListeners();
  }
  void unvalideConnection() {
    _state = false;
    notifyListeners();
  }
  void firstStepValidate() {
    _state = true;
    notifyListeners();
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('state', 1));
  }
}