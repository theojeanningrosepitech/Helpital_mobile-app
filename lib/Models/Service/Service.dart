import 'package:json_annotation/json_annotation.dart';

part 'Service.g.dart';


@JsonSerializable()
class Service {
  int id;
  String title;

  Service({this.id, this.title});


  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Map<String, dynamic> toJson(Service service) => _$ServiceToJson(service);
}



