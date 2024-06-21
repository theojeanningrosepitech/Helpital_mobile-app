import 'package:json_annotation/json_annotation.dart';

import '../Service/Service.dart';
import 'UserRole/UserRole.dart';

part 'User.g.dart';


@JsonSerializable()
class User {
  @JsonKey(name: "")

  final int id;
  final String login;
  int userRoleId;
  String userRole;
  int serviceId;
  String service;
  String firstName;
  String lastName;
  String phone;
  String email;
  var profilePicture;

  User({
    this.id,
    this.login,
    this.userRoleId,
    this.serviceId,
    this.service,
    this.userRole,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.profilePicture,
  });
  factory User.fromJson(
      Map<String, dynamic> json,
      List<UserRole> _listUserRole,
      List<Service> _listService
      ) => _$UserFromJson(json, _listUserRole, _listService);

  Map<String, dynamic> toJson(User user) => _$UserToJson(user);
}



