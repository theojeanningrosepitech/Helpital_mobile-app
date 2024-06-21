// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserRole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRole _$UserRoleFromJson(Map<String, dynamic> data) {
  return UserRole(
    id: data['id'] as int,
    title: data['role_name'] as String,
  );
}

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic> {
  'id': instance.id,
  'role_name': instance.title

};