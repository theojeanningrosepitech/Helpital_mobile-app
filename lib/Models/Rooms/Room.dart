import 'package:json_annotation/json_annotation.dart';

import '../Inventory/Inventory.dart';
import '../Patients/Patient.dart';
import '../Service/Service.dart';
import '../User/User.dart';
import '../User/UserRole/UserRole.dart';
import 'Points/Points.dart';

part 'Room.g.dart';

class TypeRoom {
  int id;
  String title;

  TypeRoom({
   this.id,
   this.title
  });
  factory TypeRoom.fromJson(Map<String, dynamic> json) => _$TypeRoomFromJson(json);

  Map<String, dynamic> toJson(TypeRoom typeRoom) => _$TypeRoomToJson(typeRoom);
}


@JsonSerializable()
class Room {
  @JsonKey(name: "")

  final int id;
  String title;
  TypeRoom type;
  int serviceId;
  int floor;
  int capacity;
  int buildingId;
  int positionX;
  int positionY;
  List<Points> corners;
  User supervisor;
  Service service;
  List<Patient> patients;
  //List<Inventory> inventory;
  Room({
    this.id,
    this.title,
    this.type,
    this.serviceId,
    this.floor,
    this.capacity,
    this.buildingId,
    this.positionX,
    this.positionY,
    this.corners,
    this.supervisor,
    this.service,
    this.patients,
    //this.inventory
  });
  factory Room.fromJson(
      Map<String, dynamic> json,
      List<UserRole> _listUserRole,
      List<Service> _listService,
      List<Patient> _listPatient
      ) => _$RoomFromJson(
      json,
      _listUserRole,
      _listService,
      _listPatient
  );

  Map<String, dynamic> toJson(Room room) => _$RoomToJson(room);
}



