import 'dart:convert';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'package:helpital_mobile_app/View/Planning/formNewEvent.dart';
import 'package:http/http.dart' as http;
import 'package:helpital_mobile_app/Services/auth.dart';

import '../Models/Patients/Patient.dart';
import '../Models/User/User.dart';

class NoteService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<bool> setNote(Patient patient, String content, int priority) async {
    try {
      User user = await UserService().getUserInfo();
      final parsed =  utils.post('note',  json.encode({
        'creator_id': user.id,
        'ss_number': patient.ssNumber,
        'patient_id': patient.id,
        'content': content,
        'priority': priority + 1
      }));
      if (parsed != null) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("ERROR PLANNING SERVICE APP: " + e.toString());
      return false;
    }
  }
}