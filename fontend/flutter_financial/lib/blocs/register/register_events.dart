import 'package:flutter_financial/Model/Request/request_register_model.dart';

abstract class RegisterEvent {}

class Register extends RegisterEvent {
  final RequestRegisterModel data;
  Register(this.data);
}
