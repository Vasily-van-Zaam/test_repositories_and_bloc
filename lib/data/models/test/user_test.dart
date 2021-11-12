import 'package:flutter_test/flutter_test.dart';
import 'package:list_users/data/fake_data/user_fake.dart';
import 'package:list_users/data/models/user.dart';

void main() {
  test('Ueser test model', () {
    User user1 = User();
    User user3 = User();
    User user2 = User(email: 'test@email.ru');

    user3.firstName = 'Job';

    expect(user1, isNot(user2));
  });
}
