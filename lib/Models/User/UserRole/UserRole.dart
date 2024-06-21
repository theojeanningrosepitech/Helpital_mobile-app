import 'package:json_annotation/json_annotation.dart';

part 'UserRole.g.dart';


@JsonSerializable()
class UserRole {
  int id;
  String title;

  UserRole({this.id, this.title});


  factory UserRole.fromJson(Map<String, dynamic> json) => _$UserRoleFromJson(json);

  Map<String, dynamic> toJson(UserRole userRole) => _$UserRoleToJson(userRole);
}



