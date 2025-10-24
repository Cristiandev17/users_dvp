part of 'list_user_cubit.dart';

enum Status { initial, loading, success, failure, error, loaded }

class ListUserState extends Equatable {
  final List<UserModel> users;
  final Status status;
  final String? message;

  const ListUserState({this.users = const [], this.status = Status.initial, this.message});

  ListUserState copyWith({List<UserModel>? users, Status? status, String? message}) {
    return ListUserState(
      users: users ?? this.users,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [users, status, message];
}
