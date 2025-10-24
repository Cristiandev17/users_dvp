import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_all_users_query.dart';

part 'list_user_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  final Mediator _mediator;

  ListUserCubit(this._mediator) : super(ListUserState(users: []));

  Future<void> getUsers() async {
    emit(state.copyWith(status: Status.loading));

    await Future.delayed(const Duration(seconds: 5));
    final result = await _mediator.sendQuery<GetAllUsersQuery, Future<List<UserModel>>>(
      GetAllUsersQuery(),
    );

    emit(state.copyWith(users: result, status: Status.loaded));
  }
}
