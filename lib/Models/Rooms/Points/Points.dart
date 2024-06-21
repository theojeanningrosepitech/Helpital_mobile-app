import 'package:json_annotation/json_annotation.dart';
part 'Points.g.dart';

@JsonSerializable()
class Points {
  @JsonKey(name: "")

  var x;
  var y;

  Points({this.x, this.y});

  factory Points.fromJson(Map<String, dynamic> json) => _$PointsFromJson(json);
  Map<String, dynamic> toJson(Points points) => _$PointsToJson(points);

}
