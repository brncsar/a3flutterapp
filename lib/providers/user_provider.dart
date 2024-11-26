import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUser(String userId) async {
    try {
      _user = await UserService.getUserById(userId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
