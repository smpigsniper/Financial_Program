import 'package:flutter_financial/Model/Request/request_login_model.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final RequestLoginModel data;
  Login(this.data);
}
