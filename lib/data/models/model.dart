import 'package:equatable/equatable.dart';

abstract class Model extends Equatable {
  Map<String, dynamic> get toJson;
}
