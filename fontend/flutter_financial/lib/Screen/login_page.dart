import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_financial/Model/Request/request_login_model.dart';
import 'package:flutter_financial/Widget/custElevatedButton.dart';
import 'package:flutter_financial/Widget/custTextField.dart';
import 'package:flutter_financial/blocs/login/login_blocs.dart';
import 'package:flutter_financial/blocs/login/login_events.dart';
import 'package:flutter_financial/blocs/login/login_states.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginLoading) {
          return _loadingPage(true);
        }

        if (state is LoginLoaded) {
          if (state.data.status == 1) {
            return _loginSuccess();
          } else {
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

  Widget _loadingPage(bool loading) {
    return _initLoginPage(true);
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
        height: 30,
      ),
      (reason == "") ? Container() : _responseReason(reason),
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

  // CustElevatedButton(
  //           text: "Login",
  //           onPressed: () {},
  //         ),

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
}
