// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'File.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> data) {
  return File(
    id: data['id'],
    fileName: data['filename'],
    content: data['content'],
    patientId: data['patient_id'],
    size: data['size'],
    type: data['type'],
    modifyAt: data['modify_at'],
    createAt: data['create_at'],
    //room: Room.fromJson(data['room'], _listUserRole, _listService, null),
  );
}

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic> {
  'id': instance.id,
  'filename': instance.fileName,
  'content': instance.content,
  'patient_id': instance.patientId,
  'size': instance.size,
  'type': instance.type,
  'modify_at': instance.modifyAt,
  'create_at': instance.createAt
};
