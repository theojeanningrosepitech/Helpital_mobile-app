import 'package:json_annotation/json_annotation.dart';

part 'Meeting.g.dart';

@JsonSerializable()
class Meeting {
  int id;
  String title;
  String description;
  String creator;
  String identity;
  String content;
  String file;
  String updateDate;
  Meeting({
    this.id,
    this.title,
    this.description,
    this.creator,
    this.identity,
    this.content,
    this.file,
    this.updateDate,
  });
  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
  Map<String, dynamic> toJson(Meeting meeting) => _$MeetingToJson(meeting);
}
