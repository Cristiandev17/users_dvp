import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/core/mediator/mediator_handler.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';

class GetUserByIdQuery extends Request<Result<UserModel>> {
  final int id;

  GetUserByIdQuery(this.id);
}
