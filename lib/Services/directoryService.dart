import 'package:helpital_mobile_app/Services/auth.dart';

class DirectoryService {
  AuthService authService = AuthService();

  Future<int> getDirectoryList() async {
    final token = await authService.getCookies();
    await Future<void>.delayed(const Duration(seconds: 0));
    return 1;
  }
  Future<void> getDirectoryElem() async {
    final token = await authService.getCookies();
    await Future<void>.delayed(const Duration(seconds: 2));

  }
}