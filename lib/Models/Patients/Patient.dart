import 'package:json_annotation/json_annotation.dart';

import '../Rooms/Room.dart';
import '../Service/Service.dart';
import '../User/UserRole/UserRole.dart';

part 'Patient.g.dart';

@JsonSerializable()
class Patient {
  int id;
  String firstname;
  String lastname;
  DateTime birthdate;
  String ssNumber;
  int roomId;
  Room room;
  double height;
  double weight;
  int age;
  int imc;

  Patient({
    this.id,
    this.birthdate,
    this.lastname,
    this.firstname,
    this.roomId,
    this.ssNumber,
    this.room,
    this.height,
    this.weight,
    this.age,
    this.imc
  });

  void setRoom(Room _room) {
    roomId = _room.id;
    room = _room;
  }
  factory Patient.fromJson(Map<String, dynamic> json, List<UserRole> _listUserRole, List<Service> _listService) => _$PatientFromJson(json, _listUserRole, _listService);
  Map<String, dynamic> toJson(Patient patient) => _$PatientToJson(patient);
}


