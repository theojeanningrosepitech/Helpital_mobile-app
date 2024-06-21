// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> data, List<UserRole> _listUserRole, List<Service> _listService) {
/*
  Widget _image;
  if (data['profilePicture'] != null) {
    var _bytesImage = convert.base64Decode(data['profilePicture']);
    _image = Image.memory(_bytesImage, fit: BoxFit.cover,);
  }
*/

  return User(
    id: data['id'] as int,
    login: data['login'] as String,
    userRoleId: data['user_role'] as int,
    userRole: _listUserRole[(data['user_role']as int) - 1].title,
    serviceId: data['service'] as int,
    service: _listService[(data['service']as int) - 1].title,
    firstName: data['firstname'],
    lastName: data['lastname'],
    phone: data['phone'],
    email: data['email'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic> {
  'id': instance.id,
  'login': instance.login,
  'user_role': instance.userRoleId,
  'user_service': instance.serviceId,
  'firstname': instance.firstName,
  'lastname': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
};