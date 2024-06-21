import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'WaitingRoom.dart';

part 'WaitingRooms.g.dart';

@JsonSerializable()
class WaitingRooms {
  @JsonKey(name: "")
  List<WaitingRoom> waitingrooms;

  WaitingRooms(this.waitingrooms);

  factory WaitingRooms.fromJson(Map<String, dynamic> json) => _$WaitingRoomsFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingRoomsToJson(this);
}



