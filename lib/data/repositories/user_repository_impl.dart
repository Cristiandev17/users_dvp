import 'package:isar/isar.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/domain/entities/user_entity.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Isar isar;

  UserRepositoryImpl(this.isar);

  @override
  Future<Result<bool>> addUser(UserEntity user) async {
    try {
      await isar.writeTxn(() async {
        await isar.userEntitys.put(user);
      });
      return Result.success(true);
    } catch (e) {
      return Result.failure(DatabaseFailure(AppMessage.addUserError));
    }
  }

  @override
  Future<Result<List<UserEntity>>> getAllUsers() async {
    final result = await isar.userEntitys.where().findAll();
    return Result.success(result);
  }

  @override
  Future<Result<UserEntity?>> getUserById(int id) async {
    final result = await isar.userEntitys.filter().idEqualTo(id).findFirst();
    return Result.success(result);
  }
}
