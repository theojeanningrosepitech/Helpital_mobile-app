
import 'package:json_annotation/json_annotation.dart';

part 'File.g.dart';

@JsonSerializable()
class File {
  int id;
  int patientId;
  String fileName;
  String content;
  String type;
  String size;
  String createAt;
  String modifyAt;

  File({
    this.id,
    this.patientId,
    this.content,
    this.fileName,
    this.type,
    this.size,
    this.createAt,
    this.modifyAt
  });

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
  Map<String, dynamic> toJson(File file) => _$FileToJson(file);
}


