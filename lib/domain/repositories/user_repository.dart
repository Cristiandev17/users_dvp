import 'package:users_dvp_app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<bool> addUser(UserEntity user);
  Future<List<UserEntity>> getAllUsers();
  Future<UserEntity?> getUserById(int id);
}
