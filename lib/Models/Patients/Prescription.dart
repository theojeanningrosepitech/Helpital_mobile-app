
import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';

part 'Prescription.g.dart';

@JsonSerializable()
class Prescription {
  int id;
  String creatorLogin;
  User creator;
  String ssNumberPatient;
  String content;

  void setCreator(User _creator) {
    creator = _creator;
  }
  Prescription({
    this.id,
    this.content,
    this.creatorLogin,
    this.ssNumberPatient
  });


  factory Prescription.fromJson(Map<String, dynamic> json) => _$PrescriptionFromJson(json);
  Map<String, dynamic> toJson(Prescription Prescription) => _$PrescriptionToJson(Prescription);
}


