// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



TypeRoom _$TypeRoomFromJson(Map<String, dynamic> data,) {

  return TypeRoom(
    id: data['id'],
    title: data['display_name']
  );
}
Map<String, dynamic> _$TypeRoomToJson(TypeRoom instance) {
  return <String, dynamic>{
    'id': instance.id,
    'display_name': instance.title,
  };
}

Room _$RoomFromJson(
    Map<String, dynamic> data,
    List<UserRole> _listUserRole,
    List<Service> _listService,
    List<Patient> _listPatient
    ) {
  List<Points> _bufferCorners = (data['corners'] as List<dynamic>).map(
          (e) => e == null ? null : Points.fromJson(e as Map<String, dynamic>)
  )?.toList();

  int _bufferId = data['id'] as int;

  List<Patient> _bufferPatient = [];
  _listPatient.forEach((element) {
    if (element.roomId == _bufferId) {
      _bufferPatient.add(element);
    }
  });


 /* List<Inventory> _bufferInventory = (data['inventory'] as List<dynamic>).map(
          (e) => e == null ? null : Inventory.fromJson(e as Map<String, dynamic>)
  )?.toList();*/


  TypeRoom _typeRoom = TypeRoom.fromJson(data['type']);

  Map<String, dynamic> _service = data['service'];
  Service _bufferService = Service(
    id: _service['id'],
    title: _service['title']
  );
  User _bufferSupervisor = User.fromJson(data['supervisor'], _listUserRole, _listService);

  return Room(
    id: _bufferId,
    title: data['title'] as String,
    type: _typeRoom,
    serviceId: data['service_id'],
    floor: data['floor'],
    capacity: data['capacity'],
    buildingId: data['building_id'],
    positionX: data['position_x'] as int,
    positionY: data['position_y'] as int,
    corners: _bufferCorners,
    supervisor: _bufferSupervisor,
    service: _bufferService,
    patients: _bufferPatient,
    //inventory: _bufferInventory
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) {
  List<String> _bufferCorners = [];
  instance.corners.forEach((Points points) {
    _bufferCorners.add('${points.x}, ${points.y}');
  });
  return <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
    'type': instance.type.toJson(instance.type),
    'service_id': instance.serviceId,
    'floor': instance.floor,
    'capacity': instance.capacity,
    'building_id': instance.buildingId,
    'position_x': instance.positionX,
    'position_y': instance.positionY,
    'corners': _bufferCorners.join(';'),
    'supervisor': instance.supervisor.id,
  };
}