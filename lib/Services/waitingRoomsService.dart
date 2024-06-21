import 'dart:convert';

import 'package:helpital_mobile_app/Models/Patients/Patient.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/patientService.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Services/utils.dart';

import 'package:http/http.dart' as http;

import '../Models/Rooms/Room.dart';
import '../Models/Service/Service.dart';
import '../Models/User/UserRole/UserRole.dart';

class WaitingRoomsService {
  AuthService authService = AuthService();
  Utils utils = Utils();
  Future<List<Room>> getWaitingRoomsServiceList() async {

    try {

      final parsed = await utils.get(Uri.parse('rooms?type=5'));
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = [];
        print('test');
        List<Room> _listRoom = (parsed).map(
                (e) => e == null ? null : Room.fromJson(e, _listUserRole, _listService, _listPatient))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR WAITINGROOMS SERVICE APP: " + e.toString());
    }
  }
  Future<List<Room>> getWaitingRoomsServiceListWithPatient() async {

    try {
      final parsed = await utils.get(Uri.parse('rooms?type=4'));
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = await PatientService().getPatients();
        print('test');
        List<Room> _listRoom = (parsed).map(
                (e) => e == null ? null : Room.fromJson(e, _listUserRole, _listService, _listPatient))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR WAITINGROOMS SERVICE APP: " + e.toString());
    }
  }
/*  Future<List<Patient>> getWaitingRoomsPatientList(int roomId) async {

    try {
      var cookie = await AuthService().getCookies();
      var cookies =  await AuthService().getCookiesJsonify();
      final response = await http.get(Uri.parse('$URL/api/patients?room_id=$roomId'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<String, dynamic>();
        final allPatient = json.decode(parsed['all_patients']).cast<Map<String, dynamic>>();
        List<Patient> _listPatient = (allPatient as List).map(
                (e) => e == null ? null : Patient.fromJson(e as Map<String, dynamic>))
            ?.toList();
        return _listPatient;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR USER WAITING ROOM SERVICE PATIENT APP: " + e.toString());
    }
  }*/
}