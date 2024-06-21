import 'package:flutter/foundation.dart';
import 'package:helpital_mobile_app/Models/Patients/File.dart';
import 'package:helpital_mobile_app/View/Note/note.dart';

import '../Models/Patients/Patient.dart';
import '../Models/Utils/ConnectionParameters.dart';

class StateManagerPatient with ChangeNotifier, DiagnosticableTreeMixin {
  bool _state = false;
  Patient _patient;
  List<File> _listFile;
  List<File> _listArchive;
  List _listNote;
  List _listPrescription;

  bool get state => _state;
  Patient get patient => _patient;
  List<File> get listFile => _listFile;
  List<File> get listArchive => _listArchive;

  void setPatient(Patient _params) {
    _patient = _params;
    notifyListeners();
  }
  void setPatientFiles(List<File> _params) {
    _listFile = _params;
    notifyListeners();
  }
  void setPatientArchives(List<File> _params) {
    _listArchive = _params;
    notifyListeners();
  }

  void connect() {
    _state = true;
    notifyListeners();

  }
  void disconnect() {
    _state = false;
    notifyListeners();

  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('state', 1));
  }
}