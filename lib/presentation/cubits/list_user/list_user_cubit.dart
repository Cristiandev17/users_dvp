import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_user_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  ListUserCubit() : super(ListUserInitial());
}
