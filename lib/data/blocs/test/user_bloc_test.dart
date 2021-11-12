import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:list_users/data/blocs/user/user_bloc.dart';
import 'package:list_users/data/fake_data/user_fake.dart';

import 'package:list_users/data/repositories/user_repository.dart';

void main() {
  late UserRepository userRepository;
  late UserBloc userBloc;

  setUp(() {
    userRepository = UserRepository(isTest: true);
    userBloc = UserBloc(userRepository);
  });

  blocTest<UserBloc, UserState>(
    'Get list users',
    build: () => userBloc,
    act: (userBloc) => userBloc.add(const UserGetList(page: 1)),
    expect: () => [UserLoading(), UserListLoaded(fakeListUsers)],
  );
}
