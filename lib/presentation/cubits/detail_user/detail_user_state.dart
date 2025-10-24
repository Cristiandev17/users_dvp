part of 'detail_user_cubit.dart';

enum Status { initial, loading, success, failure }

class DetailUserState extends Equatable {
  final UserModel? user;
  final List<AddressModel> addresses;
  final Status status;
  final String? message;

  const DetailUserState({
    this.user,
    this.addresses = const [],
    this.status = Status.initial,
    this.message,
  });

  DetailUserState copyWith({
    UserModel? user,
    List<AddressModel>? addresses,
    Status? status,
    String? message,
  }) {
    return DetailUserState(
      user: user ?? this.user,
      addresses: addresses ?? this.addresses,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [user ?? UserModel, addresses, message];
}
