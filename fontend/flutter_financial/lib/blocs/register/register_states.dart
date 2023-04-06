import 'package:flutter/material.dart';
import 'package:flutter_financial/Model/Response/response_register_model.dart';

@immutable
abstract class RegisterState {}

class RegisterInit extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final ResponseRegisterModel data;
  RegisterLoaded(this.data);
}

class RegisterError extends RegisterState {}
