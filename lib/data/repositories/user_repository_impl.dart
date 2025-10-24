import 'package:isar/isar.dart';
import 'package:users_dvp_app/domain/entities/user_entity.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Isar isar;

  UserRepositoryImpl(this.isar);

  @override
  Future<bool> addUser(UserEntity user) async {
    try {
      await isar.writeTxn(() async {
        await isar.userEntitys.put(user);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() {
    return isar.userEntitys.where().findAll();
  }

  @override
  Future<UserEntity?> getUserById(int id) {
    return isar.userEntitys.filter().idEqualTo(id).findFirst();
  }
}
