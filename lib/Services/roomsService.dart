import 'dart:convert';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/patientService.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import '../Models/Patients/Patient.dart';
import '../Models/Service/Service.dart';
import '../Models/User/UserRole/UserRole.dart';

class RoomsService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<Room>> getRoomsListWithPatient() async {
    try {
      var cookie = await AuthService().getCookies();
      final parsed = await utils.get('rooms?type=2&user_id=${cookie.userId}');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = await PatientService().getPatients();
        List<Room> _listRoom = (parsed).map(
                (e) => e == null ? null : Room.fromJson(e, _listUserRole, _listService, _listPatient))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROOMS LIST SERVICE APP: " + e.toString());
    }
  }
  Future<List<Room>> getRoomsList() async {
    try {
      var cookie = await AuthService().getCookies();
      final parsed = await utils.get('rooms?type=2&user_id=${cookie.userId}');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = [];
        List<Room> _listRoom = (parsed).map(
                (e) => e == null ? null : Room.fromJson(e, _listUserRole, _listService, _listPatient))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROOMS LIST SERVICE APP: " + e.toString());
    }
  }
  Future<List<Room>> getAllRoomsList() async {
    try {
      var cookie = await AuthService().getCookies();
      final parsed = await utils.get('rooms?user_id=${cookie.userId}');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = [];
        List<Room> _listRoom = (parsed).map(
                (e) => e == null ? null : Room.fromJson(e, _listUserRole, _listService, _listPatient))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROOMS LIST SERVICE APP: " + e.toString());
    }
  }
  Future<Room> getRoomWithPatient(int id) async {
    try {
      var cookie = await AuthService().getCookies();
      final parsed = await utils.get('rooms?type=2&user_id=${cookie.userId}&id=$id');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = await PatientService().getPatients();

        Room _room =  Room.fromJson(parsed[0], _listUserRole, _listService, _listPatient);
        return _room;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROOMS SERVICE APP: " + e.toString());
    }
  }


  Future<Room> getRoom(int id) async {
    try {
      var cookie = await AuthService().getCookies();
      final parsed = await utils.get('rooms?type=2&user_id=${cookie.userId}&id=$id');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        final List<Patient> _listPatient = [];
        Room _room =  Room.fromJson(parsed[0], _listUserRole, _listService, _listPatient);
        return _room;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROOMS SERVICE APP: " + e.toString());
    }
  }
}