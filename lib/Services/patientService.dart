import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:helpital_mobile_app/Models/Patients/Favoris.dart';
import 'package:helpital_mobile_app/Models/Patients/File.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/Models/Service/Service.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';
import 'package:helpital_mobile_app/Models/Utils/Cookies.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/stateManagerPatient.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Models/Patients/NoteModele.dart';
import '../Models/Patients/Patient.dart';
import '../Models/Patients/Prescription.dart';
import '../Models/User/UserRole/UserRole.dart';

class PatientService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<Patient>> getPatients() async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();

      final response = await http.get(Uri.parse('$URL/api/patients'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );

      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);

        List<dynamic> listParsed = parsed['patients'];

        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        List<Patient> patient = [];
        listParsed.forEach((element) {
          patient.add(Patient.fromJson(element as Map<String, dynamic>, _listUserRole, _listService));
        });
        return patient;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET PATIENT: " + e.toString());
      return null;
    }
  }

  Future<bool> getPatient(int id, BuildContext context) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();

      final response = await http.get(Uri.parse('$URL/api/patients?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );

      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);
        List<dynamic> _patient = parsed['patients'];

        List<dynamic> _fileList = parsed['patient_files']['data'];
        List<dynamic> _archiveList = parsed['patient_archives']['data'];
        List<dynamic> _noteList = parsed['notes']['data'];
        List<dynamic> _notePrescriptions = parsed['prescriptions']['data'];

        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        Patient patient = Patient.fromJson(_patient[0] as Map<String, dynamic>, _listUserRole, _listService);
        context.read<StateManagerPatient>().setPatient(patient);
        List<File> fileList = (_fileList as List).map(
                (e) => e == null ? null : File.fromJson(e as Map<String, dynamic>))
            ?.toList();
        context.read<StateManagerPatient>().setPatientFiles(fileList);
        List<File> archiveList = (_archiveList as List).map(
                (e) => e == null ? null : File.fromJson(e as Map<String, dynamic>))
            ?.toList();
        context.read<StateManagerPatient>().setPatientArchives(archiveList);

        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("ERROR GET PATIENT: " + e.toString());
      return false;
    }
  }
  Future<List<Patient>> getPatientsByRoom(int roomId) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();

      final response = await http.get(Uri.parse('$URL/api/patients?room_id=$roomId'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );

      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);
        List<dynamic> listParsed = parsed['patients'];
        List<Patient> patient = [];
        if (listParsed.length != 0) {
          final List<UserRole> _listUserRole = await UserService().getRole();
          final List<Service> _listService = await UserService().getServices();
          listParsed.forEach((element) {
            print(element);
            patient.add(Patient.fromJson(element as Map<String, dynamic>, _listUserRole, _listService));
          });
        }
/*        List<Patient> patient = (listParsed).map(
                (e) => e == null ? null : )
            ?.toList();*/
        return patient;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET FROM ROOM PATIENT: " + e.toString());
      return null;
    }
  }

  Future<bool> updatePatient(Patient patient, Room room) async {
    try {

      patient.setRoom(room);
      var cookies =  await AuthService().getCookiesJsonify();
      final response = await http.put(Uri.parse('$URL/api/patients?id=${patient.id}'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
        body: json.encode({
          'room_id': patient != null ? patient.roomId.toString() : '0',
          //'room': patient.room.toJson(patient.room).toString()
        })
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("ERROR PATIENT UPDATE SERVICE APP: " + e.toString());
      return false;
    }
  }
  Future<List<NoteModele>> getNotePatient(int id) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();
      final response = await http.get(Uri.parse('$URL/api/patients?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);

        List<dynamic> _noteList = parsed['notes']['data'];
        List<NoteModele> listNote = (_noteList).map(
                (e) => e == null ? null : NoteModele.fromJson(e as Map<String, dynamic>))
            ?.toList();
       listNote.forEach((element) async {
         User creator = await UserService().getUserbyId(element.creatorId);
         element.setCreator(creator);
       });
        return listNote;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET PATIENT: " + e.toString());
      return null;
    }
  }
  Future<List<Prescription>> getPrescriptionPatient(int id) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();
      final response = await http.get(Uri.parse('$URL/api/patients?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);

        List<dynamic> _prescriptionsList = parsed['prescriptions']['data'];
        List<Prescription> listNote = (_prescriptionsList).map(
                (e) => e == null ? null : Prescription.fromJson(e as Map<String, dynamic>))
            ?.toList();
        listNote.forEach((element) async {
          User creator = await UserService().getUserBylogin(element.creatorLogin);
          element.setCreator(creator);
        });
        return listNote;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET PATIENT: " + e.toString());
      return null;
    }
  }
  Future<List<File>> getFilePatient(int id) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();
      final response = await http.get(Uri.parse('$URL/api/patients?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);
        List<dynamic> _filesList = parsed['patient_files']['data'];
        List<File> listFiles = (_filesList).map(
                (e) => e == null ? null : File.fromJson(e as Map<String, dynamic>))
            ?.toList();
        return listFiles;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET PATIENT: " + e.toString());
      return null;
    }
  }
  Future<List<File>> getArchivePatient(int id) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();
      final response = await http.get(Uri.parse('$URL/api/patients?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);
        List<dynamic> _filesList = parsed['patient_archives']['data'];
        List<File> listFiles = (_filesList).map(
                (e) => e == null ? null : File.fromJson(e as Map<String, dynamic>))
            ?.toList();

        return listFiles;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET PATIENT: " + e.toString());
      return null;
    }
  }

  Future<List<Favoris>> getFavoris() async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();
      Cookies cookie = await AuthService().getCookies();


      final response = await http.get(Uri.parse('$URL/api/patients/favoris?id=${cookie.userId}'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );

      if (response.statusCode == 200) {
        final parsed = convert.jsonDecode(response.body);
        List<dynamic> listParsed = parsed;
        List<Favoris> favoris = [];
        if (listParsed.length != 0) {
          listParsed.forEach((element) {
            favoris.add(Favoris.fromJson(element as Map<String, dynamic>));
          });
        }
        return favoris;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET FROM ROOM PATIENT: " + e.toString());
      return null;
    }
  }
  Future<void> deleteFavoris(patientId) async {
    try{
      var cookies =  await AuthService().getCookiesJsonify();
      Cookies cookie = await AuthService().getCookies();


      await http.delete(Uri.parse('$URL/api/patients/favoris?id=$patientId'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
    } catch(e) {
      print("ERROR GET FROM ROOM PATIENT: " + e.toString());
      return null;
    }
  }
  Future<bool> setFavoris(patientId) async {
    try{
      Cookies cookie = await AuthService().getCookies();

      return utils.post('patients/favoris?user_id=${cookie.userId}&patient_id=$patientId',
          json.encode({}));
    } catch(e) {
      print("ERROR GET FROM ROOM PATIENT: " + e.toString());
      return null;
    }
  }
}