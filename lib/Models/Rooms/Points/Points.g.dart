
part of 'Points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Points _$PointsFromJson(Map<String, dynamic> data) {
  return Points(
      x: data['x'],
      y: data['y']
  );
}

Map<String, dynamic> _$PointsToJson(Points instance) => <String, dynamic> {
  'x': instance.x,
  'y': instance.y,
};
