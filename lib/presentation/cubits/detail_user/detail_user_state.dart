part of 'detail_user_cubit.dart';

enum Status { initial, loading, success, failure }

class DetailUserState extends Equatable {
  final UserModel? user;
  final List<AddressModel> addresses;
  final Status status;
  const DetailUserState({this.user, this.addresses = const [], this.status = Status.initial});

  DetailUserState copyWith({UserModel? user, List<AddressModel>? addresses, Status? status}) {
    return DetailUserState(
      user: user ?? this.user,
      addresses: addresses ?? this.addresses,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [user ?? UserModel, addresses];
}
