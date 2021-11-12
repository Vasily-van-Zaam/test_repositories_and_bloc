import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:list_users/data/fake_data/user_fake.dart';
import 'package:list_users/data/models/user.dart';

abstract class UserRepositoryRequest {
  Future fetchListUsers({int? indexPage});
  Future fetchCreateUser(User user);
}

class UserRepository extends UserRepositoryRequest {
  Dio? dio;
  bool isTest;

  UserRepository({this.dio, this.isTest = false}) {
    dio ??= Dio(BaseOptions(baseUrl: 'https://reqres.in'));
  }

  @override
  Future fetchCreateUser(User user) async {}

  @override
  Future fetchListUsers({int? indexPage}) async {
    var route = '/api/users/';
    if (indexPage is int) {
      route = '/api/users?page=$indexPage';
    }
    ////////// DATA FOR TEST ////////
    if (isTest) {
      DioAdapter dioAdapter = DioAdapter(dio: dio!);
      dioAdapter.onGet(route, (server) => server.reply(200, fakeListUsersJson));
    }
    ////////// END  DATA FOR TEST ////////

    try {
      var res = await dio!.get(route,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status != null && status <= 500;
              },
              headers: {
                Headers.contentTypeHeader: 'application/json',
              }));
      if (res.statusCode == 200) {
        List<User> list = [];
        for (var json in res.data['data']) {
          list.add(User.fromJson(json));
        }
        return list;
      } else {
        return res.data.toString();
      }
    } catch (e) {
      rethrow;
    }
  }
}
