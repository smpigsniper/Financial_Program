import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_financial/Model/Request/request_register_model.dart';
import 'package:flutter_financial/Widget/custElevatedButton.dart';
import 'package:flutter_financial/Widget/custTextField.dart';
import 'package:flutter_financial/blocs/register/register_blocs.dart';
import 'package:flutter_financial/blocs/register/register_events.dart';
import 'package:flutter_financial/blocs/register/register_states.dart';
import 'package:flutter_financial/color.dart';
import 'package:flutter_financial/fontSize.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final CustColors _custColors = CustColors();
  final CustFontSize _custFontSize = CustFontSize();
  final List<TextEditingController> _textEditingControllerList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> _focusNodeList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  bool _isPasswordValid = true;
  bool _isUsernameValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _custColors.secondaryColor[0],
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RegisterLoaded) {
            if (state.data.status == 1) {
              _resetState();
              return _registerLaodedPage();
            } else if (state.data.status == 0) {
              return _registerInitPage(false, reason: state.data.reason);
            }
          }
          if (state is RegisterLoading) {
            return _registerInitPage(true);
          }
          return _registerInitPage(false);
        },
      ),
    );
  }

  Widget _registerInitPage(bool isLoading, {String reason = ""}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _editTextField(
            _textEditingControllerList[0],
            _focusNodeList[0],
            "Username",
            Icons.account_circle,
            false,
            isValid: _isUsernameValid,
            errorText: "Username is not empty!",
          ),
          const SizedBox(
            height: 30,
          ),
          _editTextField(
            _textEditingControllerList[1],
            _focusNodeList[1],
            "Password",
            Icons.account_circle,
            true,
          ),
          const SizedBox(
            height: 30,
          ),
          _editTextField(_textEditingControllerList[2], _focusNodeList[2],
              "Confrim Password", Icons.account_circle, true,
              isValid: _isPasswordValid,
              errorText: "Password & Confirm Password does not match!"),
          const SizedBox(
            height: 30,
          ),
          (reason == "") ? Container() : _responseReason(reason),
          const SizedBox(
            height: 10,
          ),
          (isLoading)
              ? const CircularProgressIndicator()
              : CustElevatedButton(
                  text: "Register",
                  onPressed: () {
                    _isPasswordValid = (_textEditingControllerList[1].text ==
                            _textEditingControllerList[2].text &&
                        _textEditingControllerList[1].text != '');
                    _isUsernameValid =
                        (_textEditingControllerList[0].text != '');
                    RequestRegisterModel registerData = RequestRegisterModel(
                      username: _textEditingControllerList[0].text,
                      password: _textEditingControllerList[1].text,
                    );
                    if (_isPasswordValid &&
                        _textEditingControllerList[0].text != '') {
                      _registerButtonPress(registerData);
                    }

                    setState(() {});
                  },
                ),
        ],
      ),
    );
  }

  Widget _registerLaodedPage() {
    return CupertinoAlertDialog(
      content: const Text('Register Successful'),
      title: const Text(''),
      actions: [
        CupertinoDialogAction(
          child: const Text(
            'OK',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget _responseReason(String reason) {
    return Text(
      reason,
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _editTextField(TextEditingController controller, FocusNode focusNode,
      String name, IconData iconData, bool isPassword,
      {bool isValid = true, String errorText = ""}) {
    return CustTextField(
      text: name,
      controller: controller,
      focusNode: focusNode,
      iconData: iconData,
      hideText: isPassword,
      errorText: (!isValid) ? errorText : null,
    );
  }

  void _registerButtonPress(RequestRegisterModel registerData) {
    if (_isPasswordValid) {
      BlocProvider.of<RegisterBloc>(context).add(Register(registerData));
    }
  }

  void _resetState() {
    BlocProvider.of<RegisterBloc>(context).emit(RegisterInit());
  }
}
