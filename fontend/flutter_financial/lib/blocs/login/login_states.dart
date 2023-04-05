import 'package:flutter/material.dart';
import 'package:flutter_financial/Model/Response/response_login_model.dart';

@immutable
abstract class LoginState {}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final ResponseLoginModel data;
  LoginLoaded(this.data);
}

class LoginError extends LoginState {}
