import '../models/user_model.dart';
import '../services/user_service.dart';

class UserRepository {
  final UserService service;

  UserRepository(this.service);

  Future<UserModel?> getUser(String uid) async {
    return await service.getUser(uid);
  }

  Future<void> createUser(UserModel user) async {
    await service.createUser(user);
  }

  Future<bool> isUsernameAvailable(String username) async {
    return await service.isUsernameAvailable(username);
  }

  Future<void> updateUsername(String uid, String username) async {
    await service.updateUsername(uid, username);
  }
}