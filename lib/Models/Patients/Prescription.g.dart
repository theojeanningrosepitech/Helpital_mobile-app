// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prescription _$PrescriptionFromJson(Map<String, dynamic> data) {
  return Prescription(
    id: data['id'],
    content: data['p_content'],
    creatorLogin: data['p_creator'],
    ssNumberPatient: data['p_attached_to'],
  );
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) => <String, dynamic> {
  'id': instance.id,
  'n_content': instance.content,
  'n_creator': instance.creator.login,
  'n_attached_to': instance.ssNumberPatient,
};
