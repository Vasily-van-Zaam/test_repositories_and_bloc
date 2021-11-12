part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetList extends UserEvent {
  final int? page;

  const UserGetList({this.page});
  @override
  List<Object> get props => [];
}
