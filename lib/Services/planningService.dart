import 'dart:convert';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'package:helpital_mobile_app/View/Planning/formNewEvent.dart';
import 'package:helpital_mobile_app/Models/Planning/Event.dart';
import 'package:helpital_mobile_app/Services/auth.dart';

class PlanningService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<Event>> getPlanning() async {
    try {
      final parsed = await utils.get('planning?from=0001-01-01&to=9999-01-01');
      if (parsed != null) {
        List<Event> _listRoom = (parsed).map(
                (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR PLANNING SERVICE APP: " + e.toString());
    }
  }

  Future<List<Event>> getPlanningOfTheDay(from, to) async {
    try {
      final parsed = await utils.get('planning?from=$from&to=$to');
      if (parsed != null) {
        List<Event> _listRoom = (parsed).map(
                (e) => e == null ? null : Event.fromJson(e))
            ?.toList();
        return _listRoom;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR PLANNING SERVICE APP: " + e.toString());
    }
  }

  Future<bool> setNewEvent(NewEvent event) async {
    try {
      final parsed = await utils.post(
          'planning',
          json.encode({
            'title': event.title,
            'description': event.description,
            'begin_at': event.startDate.toString(),
            'end_at': event.endDate.toString()
          })
      );
      if (parsed != null) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("ERROR PLANNING SERVICE APP: " + e.toString());
      return false;
    }
  }
}