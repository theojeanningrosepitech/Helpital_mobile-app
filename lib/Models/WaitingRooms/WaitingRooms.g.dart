// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WaitingRooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingRooms _$WaitingRoomsFromJson(Map<String, dynamic> data) {
  return WaitingRooms((json as List)
      ?.map(
          (e) => e == null ? null : WaitingRoom.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$WaitingRoomsToJson(WaitingRooms instance) {
  return <String, dynamic>{"": instance.waitingrooms};

}
