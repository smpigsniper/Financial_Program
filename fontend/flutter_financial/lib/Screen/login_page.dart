import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_financial/Model/Request/request_login_model.dart';
import 'package:flutter_financial/Model/Response/response_login_model.dart';
import 'package:flutter_financial/Repositories/RegisterResponse.dart';
import 'package:flutter_financial/Screen/register_page.dart';
import 'package:flutter_financial/Widget/custElevatedButton.dart';
import 'package:flutter_financial/Widget/custTextButton.dart';
import 'package:flutter_financial/Widget/custTextField.dart';
import 'package:flutter_financial/apiRequest.dart';
import 'package:flutter_financial/blocs/login/login_blocs.dart';
import 'package:flutter_financial/blocs/login/login_events.dart';
import 'package:flutter_financial/blocs/login/login_states.dart';
import 'package:flutter_financial/blocs/register/register_blocs.dart';
import 'package:flutter_financial/color.dart';
import 'package:flutter_financial/fontSize.dart';
import 'package:flutter_financial/globalVar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<TextEditingController> _textEditingControllerList = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> _focusNodeList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final CustColors _custColors = CustColors();
  final CustFontSize _custFontSize = CustFontSize();
  final RegisterBloc _registerBloc = RegisterBloc(RegisterResponse());

  late String _username = "";
  late String _accessToken = "";

  void _loadData() async {
    BlocProvider.of<LoginBloc>(context).emit(LoginLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken') ?? "";
    _username = prefs.getString('username') ?? "";
    if (_username != "" && _accessToken != "") {
      _refreshToken(_username);
    }
  }

  void _refreshToken(String username) async {
    late RequestLoginModel requestLoginModel =
        RequestLoginModel(username: username, password: "");
    late ResponseLoginModel responseDataModel;
    String data = "";
    data = await APIRequest.postRequest(
        "${GlobalVar.apiIp}refreshToken", "", requestLoginModel.toJson());
    responseDataModel = ResponseLoginModel.fromJson(jsonDecode(data));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", responseDataModel.accessToken);
    BlocProvider.of<LoginBloc>(context).emit(LoginLoaded(responseDataModel));
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginLoading) {
          return _initLoginPage(true);
        }

        if (state is LoginLoaded) {
          if (state.data.status == 1) {
            _savePrefs(state.data);
            return _loginSuccess(state.data);
          } else if (state.data.status == 0) {
            return _initLoginPage(false, reason: state.data.reason);
          }
        }

        return _initLoginPage(false);
      },
    ));
  }

  List<Widget> _mainField(bool loading, {String reason = ""}) {
    return [
      _editTextField(_textEditingControllerList[0], _focusNodeList[0],
          "Username", Icons.account_circle, false),
      const SizedBox(
        height: 30,
      ),
      _editTextField(_textEditingControllerList[1], _focusNodeList[1],
          "Password", Icons.key, true),
      const SizedBox(
        height: 20,
      ),
      CustTextButton(
        onPressed: _registerButtonPress,
        textColor: _custColors.primaryColor[0],
        text: 'Register',
        fontSize: _custFontSize.primaryFontSize[3],
      ),
      const SizedBox(
        height: 10,
      ),
      (reason == "") ? Container() : _responseReason(reason),
      const SizedBox(
        height: 10,
      ),
      (loading)
          ? const CircularProgressIndicator()
          : CustElevatedButton(
              text: "Login",
              onPressed: () {
                RequestLoginModel loginData = RequestLoginModel(
                    username: _textEditingControllerList[0].text,
                    password: _textEditingControllerList[1].text);
                _loginButtonPress(loginData);
                setState(() {});
              },
            ),
    ];
  }

  Widget _responseReason(String reason) {
    return Text(
      reason,
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _initLoginPage(bool loading, {String reason = ""}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _mainField(loading, reason: reason),
      ),
    );
  }

  Widget _editTextField(TextEditingController controller, FocusNode focusNode,
      String name, IconData iconData, bool isPassword) {
    return CustTextField(
      text: name,
      controller: controller,
      focusNode: focusNode,
      iconData: iconData,
      hideText: isPassword,
    );
  }

  void _loginButtonPress(RequestLoginModel data) {
    BlocProvider.of<LoginBloc>(context).add(Login(data));
  }

  Future<void> _savePrefs(ResponseLoginModel data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", data.username);
    await prefs.setString("accessToken", data.accessToken);
  }

  void _registerButtonPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _registerBloc,
          child: const RegisterPage(),
        ),
      ),
    );
  }

  Widget _loginSuccess(ResponseLoginModel data) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(data.username),
            Text(data.accessToken),
          ],
        ),
      ),
    );
  }
}
