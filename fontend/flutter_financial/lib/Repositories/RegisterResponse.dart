import 'dart:convert';

import 'package:flutter_financial/Model/Request/request_register_model.dart';
import 'package:flutter_financial/Model/Response/response_register_model.dart';
import 'package:flutter_financial/apiRequest.dart';
import 'package:flutter_financial/globalVar.dart';

abstract class RegisterRepository {
  Future<ResponseRegisterModel> registerData(RequestRegisterModel requestData);
}

class RegisterResponse extends RegisterRepository {
  @override
  Future<ResponseRegisterModel> registerData(
      RequestRegisterModel requestData) async {
    String responseData = await APIRequest.postRequest(
        "${GlobalVar.apiIp}register", "", requestData.toJson());
    return ResponseRegisterModel.fromJson(jsonDecode(responseData));
  }
}
