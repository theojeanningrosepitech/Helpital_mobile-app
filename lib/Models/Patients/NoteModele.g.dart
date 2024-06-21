// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteModele.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModele _$NoteModeleFromJson(Map<String, dynamic> data) {
  return NoteModele(
    id: data['id'],
    content: data['content'],
    creatorId: data['creator_id'],
    ssNumberPatient: data['ss_number'],
    patientId: data['patient_id'],
    priority: data['priority'],
  );
}

Map<String, dynamic> _$NoteModeleToJson(NoteModele instance) => <String, dynamic> {
  'id': instance.id,
  'content': instance.content,
  'creator_id': instance.creator.id,
  'ss_number': instance.ssNumberPatient,
  'patient_id': instance.patientId,
  'priority': instance.priority
};
