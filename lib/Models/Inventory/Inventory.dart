import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Service/Service.dart';

part 'Inventory.g.dart';

class TypeTool {
  int id;
  String name;
  String displayName;
  TypeTool({
    this.id,
    this.name,
    this.displayName
  });
}

@JsonSerializable()
class Inventory {
  int id;
  String title;
  TypeTool type;
  int roomId;
  Room room;
  int quantity;
  String updateDate;

  Inventory({
    this.id,
    this.roomId,
    this.room,
    this.title,
    this.type,
    this.quantity,
    this.updateDate
  });

  void setRoom(Room _room) {
    room = _room;
  }
  factory Inventory.fromJson(Map<String, dynamic> json) => _$InventoryFromJson(json);
  Map<String, dynamic> toJson(Inventory inventory) => _$InventoryToJson(inventory);
}