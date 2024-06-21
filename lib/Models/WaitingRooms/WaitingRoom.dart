import 'package:json_annotation/json_annotation.dart';

part 'WaitingRoom.g.dart';

@JsonSerializable()
class WaitingRoom {
  @JsonKey(name: "")

  final int id;
  String title;
  int serviceId;
  int floor;
  int capacity;
  String firstName;
  String lastName;

  WaitingRoom({
    this.id,
    this.title,
    this.serviceId,
    this.floor,
    this.capacity,
    this.firstName,
    this.lastName
  });
  factory WaitingRoom.fromJson(Map<String, dynamic> json) => _$WaitingRoomFromJson(json);

  Map<String, dynamic> toJson(WaitingRoom waitingRoom) => _$WaitingRoomToJson(waitingRoom);
}



