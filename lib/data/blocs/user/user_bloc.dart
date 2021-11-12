import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:list_users/data/models/user.dart';
import 'package:list_users/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield UserLoading();

    if (event is UserGetList) {
      try {
        var res = await userRepository.fetchListUsers(indexPage: event.page);
        if (res is List<User>) {
          yield UserListLoaded(res);
        } else {
          yield UserError(res.toString());
        }
      } catch (e) {
        yield UserError(e.toString());
      }
    }
  }
}
