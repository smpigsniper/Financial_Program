import 'dart:convert';

import 'package:flutter_financial/Model/Request/request_login_model.dart';
import 'package:flutter_financial/Model/Response/response_login_model.dart';
import 'package:flutter_financial/apiRequest.dart';
import 'package:flutter_financial/globalVar.dart';

abstract class LoginRepository {
  Future<ResponseLoginModel> loginData(RequestLoginModel requestData);
}

class LoginResponse extends LoginRepository {
  @override
  Future<ResponseLoginModel> loginData(RequestLoginModel requestData) async {
    String responseData = await APIRequest.postRequest(
        "${GlobalVar.apiIp}login", "", requestData.toJson());
    return ResponseLoginModel.fromJson(jsonDecode(responseData));
  }
}
