import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';

class GetAllUsersQuery extends IQuery<Future<Result<List<UserModel>>>> {}
