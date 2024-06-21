// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Meeting.dart';

Meeting _$MeetingFromJson(Map<String, dynamic> data) {
  return Meeting(
    id: data['id'],
    title: data['title'],
    description: data['description'],
    creator: data['n_creator'],
    identity: data['identity'],
    content: data['n_content'],
    file: data['file'],
    updateDate: data['creation_date'],
  );
}

Map<String, dynamic> _$MeetingToJson(Meeting instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'n_creator': instance.creator,
      'identity': instance.identity,
      'n_content': instance.content,
      'file': instance.file,
      'creation_date': instance.updateDate,
    };
