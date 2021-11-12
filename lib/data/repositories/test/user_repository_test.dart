import 'package:flutter_test/flutter_test.dart';
import 'package:list_users/data/fake_data/user_fake.dart';
import 'package:list_users/data/models/user.dart';

import '../user_repository.dart';

void main() {
  late UserRepository userRepository;

  setUp(() {
    userRepository = UserRepository(isTest: true);
  });

  test('Test user repository fetch list users', () async {
    var res = await userRepository.fetchListUsers();

    expect(res, fakeListUsers);
  });
}
