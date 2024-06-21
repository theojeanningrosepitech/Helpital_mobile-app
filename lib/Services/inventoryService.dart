import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import '../Models/Inventory/Inventory.dart';

class InventoryService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<Inventory>> getInventoryList() async {
    try {

      final parsed = await utils.get(Uri.parse('inventory'));
      if (parsed != null) {
        List<Inventory> _listInventory = (parsed).map(
                (e) => e == null ? null : Inventory.fromJson(e))
            ?.toList();
        return _listInventory;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR INVENTORY SERVICE APP: " + e.toString());
    }
  }


}