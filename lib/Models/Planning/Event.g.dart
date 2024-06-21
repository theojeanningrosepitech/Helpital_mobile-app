// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> data) {
  String creat = data['creation_date'] as String;
  String begin = data['begin_at'] as String;
  String end = data['end_at'] as String;

  return Event(
    title: data['title'] as String,
    description: data['description'] as String,
    creationDate: DateTime.parse(creat),
    userId: data['user_id'],
    beginAt:  DateTime.parse(begin),
    endAt:  DateTime.parse(end),
    duration: data['duration']
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic> {
  'title': instance.title,
  'description': instance.description,
  'creation_date': instance.creationDate,
  'user_id': instance.userId,
  'begin_at': instance.beginAt,
  'end_at': instance.endAt,
  'duration': instance.duration,
};