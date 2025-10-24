import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_all_users_query.dart';

part 'list_user_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  final Mediator _mediator;

  ListUserCubit(this._mediator) : super(ListUserState(users: []));

  Future<void> getUsers() async {
    emit(state.copyWith(status: Status.loading));

    await Future.delayed(const Duration(seconds: 5));
    final result = await _mediator.sendQuery<GetAllUsersQuery, Future<Result<List<UserModel>>>>(
      GetAllUsersQuery(),
    );

    if (result.isFailure) {
      emit(state.copyWith(status: Status.failure, message: result.failure!.message));
      return;
    }

    emit(
      state.copyWith(
        users: result.value,
        status: Status.loaded,
        message: AppMessage.usersGetSuccess,
      ),
    );
  }
}
