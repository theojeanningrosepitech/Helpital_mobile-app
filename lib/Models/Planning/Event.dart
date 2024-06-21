import 'package:json_annotation/json_annotation.dart';

part 'Event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: "")

  String title;
  String description;
  DateTime creationDate;
  int userId;
  DateTime beginAt;
  DateTime endAt;
  int duration;

  Event({
    this.title,
    this.description,
    this.creationDate,
    this.userId,
    this.beginAt,
    this.endAt,
    this.duration
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson(Event event) => _$EventToJson(event);
}



