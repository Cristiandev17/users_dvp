import 'package:flutter_bloc/flutter_bloc.dart';

mixin StateUpdaterMixin<S> on Cubit<S> {
  /// Updates the state with the given input and copyWith logic.
  void updateState<T>(T input, T Function(S) stateField, S Function(S, T) copyWithField) {
    emit(copyWithField(state, input));
  }
}
