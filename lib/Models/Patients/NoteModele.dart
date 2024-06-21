
import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';

part 'NoteModele.g.dart';

@JsonSerializable()
class NoteModele {
  int id;
  int creatorId;
  int patientId;
  User creator;
  String ssNumberPatient;
  String content;
  int priority;

  void setCreator(User _creator) {
    creator = _creator;
  }
  NoteModele({
    this.id,
    this.content,
    this.creatorId,
    this.ssNumberPatient,
    this.priority,
    this.patientId
  });


  factory NoteModele.fromJson(Map<String, dynamic> json) => _$NoteModeleFromJson(json);
  Map<String, dynamic> toJson(NoteModele noteModele) => _$NoteModeleToJson(noteModele);
}


