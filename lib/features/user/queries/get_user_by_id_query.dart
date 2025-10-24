import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';

class GetUserByIdQuery extends IQuery<Future<UserModel>> {
  final int id;

  GetUserByIdQuery(this.id);
}
