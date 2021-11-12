// ignore_for_file: must_be_immutable

import 'package:list_users/data/models/model.dart';

class User extends Model {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  User({this.id, this.firstName, this.lastName, this.email, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      avatar: json["avatar"]);

  @override
  List<Object?> get props => [id, firstName, lastName, email, avatar];

  @override
  Map<String, dynamic> get toJson => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "avatar": avatar
      };
}
