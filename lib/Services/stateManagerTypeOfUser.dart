import 'package:flutter/foundation.dart';

import '../Models/Utils/ConnectionParameters.dart';

class StateManagerTypeOfUser with ChangeNotifier, DiagnosticableTreeMixin {
  bool _state = false;
  TypeOfUser _typeOfUser = TypeOfUser.NoSelected;

  bool get state => _state;
  TypeOfUser get typeOfUser => _typeOfUser;

  void setUser(TypeOfUser _params) {
    _typeOfUser = _params;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('state', 1));
  }
}