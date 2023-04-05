import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_financial/Model/Response/response_login_model.dart';
import 'package:flutter_financial/Repositories/LoginResponse.dart';
import 'package:flutter_financial/blocs/login/login_events.dart';
import 'package:flutter_financial/blocs/login/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late ResponseLoginModel responseData;
  late LoginResponse data;
  LoginBloc(this.data) : super(LoginInit()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        emit(LoginLoading());
        responseData = await data.loginData(event.data);
        emit(LoginLoaded(responseData));
      }
    });
  }
}
