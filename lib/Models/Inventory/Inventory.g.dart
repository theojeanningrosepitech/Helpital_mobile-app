
part of 'Inventory.dart';

Inventory _$InventoryFromJson(Map<String, dynamic> data) {
  Map<String, dynamic> type = data['type'];
  // Map<String, dynamic> _room = data['room'];
  // Map<String, dynamic> _type = _room['type'];
  // Map<String, dynamic> _service = _room['service'];
  return Inventory(
      id: data['id'],
      title: data['title'],
      type: TypeTool(
        id: type['id'],
        name: type['name'],
        displayName: type['display_name'],
      ),
      roomId: data['room_id'],
      room: null,
      /*room: Room(
          id: _room['id'] as int,
          title: _room['title'] as String,
          type: TypeRoom(
              title: _type['display_name']
          ),
          serviceId: _room['service_id'],
          floor: _room['floor'],
          capacity: _room['capacity'],
          service: Service(
              id: _service['id'] as int,
              title: _service['title']
          )
      ),*/
      quantity: data['quantity'],
      updateDate: data['update_date']
  );
}

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic> {
  'id': instance.id,
};

