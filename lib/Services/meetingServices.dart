import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/utils.dart';

import '../Models/Meeting/Meeting.dart';

class MeetingService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<Meeting>> getMeetingList() async {
    try {
      final parsed = utils.get('meeting');
      if (parsed != null) {
        List<Meeting> meetingList = (parsed as List).map(
                (e) => e == null ? null : Meeting.fromJson(e as Map<String, dynamic>))
            ?.toList();
        return meetingList;
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR MEETING SERVICE APP: " + e.toString());
      return [];
    }
  }
}
