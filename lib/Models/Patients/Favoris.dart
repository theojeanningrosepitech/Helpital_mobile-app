import 'package:json_annotation/json_annotation.dart';

part 'Favoris.g.dart';

@JsonSerializable()
class Favoris {
  int id;
  int patientId;
  int userId;


  Favoris({
    this.id,
    this.patientId,
    this.userId,
  });

  factory Favoris.fromJson(Map<String, dynamic> json) => _$FavorisFromJson(json);
  Map<String, dynamic> toJson(Favoris favoris) => _$FavorisToJson(favoris);
}


