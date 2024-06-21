// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> data, List<UserRole> _listUserRole, List<Service> _listService) {
  double _height = data['height'];
  double _weight = data['weight'];
  return Patient(
    id: data['id'],
    firstname: data['firstname'],
    lastname: data['lastname'],
    birthdate: DateTime.parse(data['birthdate']),
    ssNumber: data['ss_number'],
    roomId: data['room_id'],
    height: _height,
    weight: _weight,
    age: data['age'],
    imc: data['imc']
    //room: Room.fromJson(data['room'], _listUserRole, _listService, null),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic> {
  'id': instance.id,
  'firstname': instance.firstname,
  'lastname': instance.lastname,
  'birthdate': instance.birthdate,
  'ss_number': instance.ssNumber,
  'room_id': instance.roomId,
  'room': Room().toJson(instance.room)
};
