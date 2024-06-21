// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WaitingRoom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingRoom _$WaitingRoomFromJson(Map<String, dynamic> data) {
  return WaitingRoom(
    id: data['id'] as int,
    title: data['title'],
    serviceId: data['service_id'],
    floor: data['floor'],
    capacity: data['capacity'],
    firstName: data['firstname'],
    lastName: data['lastname'],
  );
}

Map<String, dynamic> _$WaitingRoomToJson(WaitingRoom instance) => <String, dynamic> {
  'id': instance.id,
  'title': instance.title,
  'service_id': instance.serviceId,
  'floor': instance.floor,
  'capacity': instance.capacity,
  'firstname': instance.firstName,
  'lastname': instance.lastName,
};