part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);
  @override
  List<Object> get props => [message];
}

class UserListLoaded extends UserState {
  final List<User> list;

  const UserListLoaded(this.list);

  @override
  List<Object> get props => [list];
}
