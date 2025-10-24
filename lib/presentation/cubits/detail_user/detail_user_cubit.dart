import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/mediator/mediator.dart';
import 'package:users_dvp_app/domain/models/address_model.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_user_by_id_query.dart';

part 'detail_user_state.dart';

class DetailUserCubit extends Cubit<DetailUserState> {
  final Mediator _mediator;
  DetailUserCubit(this._mediator) : super(DetailUserState());

  Future<void> getUserById(int id) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final user = await _mediator.send(GetUserByIdQuery(id));
      if (user.value?.id == 0) {
        emit(state.copyWith(status: Status.failure, message: AppMessage.noUserFound));
        return;
      }
      emit(
        state.copyWith(
          status: Status.success,
          user: user.value,
          message: AppMessage.userGetSuccess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: AppMessage.unknownError));
    }
  }
}
