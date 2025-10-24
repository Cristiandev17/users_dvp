import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Result<bool>> addUser(UserEntity user);
  Future<Result<List<UserEntity>>> getAllUsers();
  Future<Result<UserEntity?>> getUserById(int id);
}
