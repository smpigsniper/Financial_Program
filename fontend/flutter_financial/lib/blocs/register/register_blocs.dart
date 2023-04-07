import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_financial/Model/Response/response_register_model.dart';
import 'package:flutter_financial/Repositories/RegisterResponse.dart';
import 'package:flutter_financial/blocs/register/register_events.dart';
import 'package:flutter_financial/blocs/register/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  late ResponseRegisterModel responseData;
  late RegisterResponse data;
  RegisterBloc(this.data) : super(RegisterInit()) {
    on<RegisterEvent>((event, emit) async {
      if (event is Register) {
        emit(RegisterLoading());
        responseData = await data.registerData(event.data);
        emit(RegisterLoaded(responseData));
      }
      emit(RegisterInit());
    });
  }
}
