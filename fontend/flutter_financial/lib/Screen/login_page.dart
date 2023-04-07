import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_financial/Model/Request/request_login_model.dart';
import 'package:flutter_financial/Repositories/RegisterResponse.dart';
import 'package:flutter_financial/Screen/register_page.dart';
import 'package:flutter_financial/Widget/custElevatedButton.dart';
import 'package:flutter_financial/Widget/custTextButton.dart';
import 'package:flutter_financial/Widget/custTextField.dart';
import 'package:flutter_financial/blocs/login/login_blocs.dart';
import 'package:flutter_financial/blocs/login/login_events.dart';
import 'package:flutter_financial/blocs/login/login_states.dart';
import 'package:flutter_financial/blocs/register/register_blocs.dart';
import 'package:flutter_financial/color.dart';
import 'package:flutter_financial/fontSize.dart';

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
            return _loginSuccess();
          } else if (state.data.status == 0) {
            return _initLoginPage(false, reason: state.data.reason);
          }
        }

        return _initLoginPage(false);
      },
    ));
  }

  Widget _loginSuccess() {
    return Container();
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
}
