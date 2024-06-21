// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Favoris.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favoris _$FavorisFromJson(Map<String, dynamic> data) {

  return Favoris(
    id: data['id'],
    patientId: data['patient_id'],
    userId: data['user_id'],
  );
}

Map<String, dynamic> _$FavorisToJson(Favoris instance) => <String, dynamic> {
  'id': instance.id,
  'patient_id': instance.patientId,
  'user_id': instance.userId,
};
