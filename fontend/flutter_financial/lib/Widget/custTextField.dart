import 'package:flutter/material.dart';
import 'package:flutter_financial/color.dart';

class CustTextField extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final bool? hideText;
  final String? errorText;
  const CustTextField(
      {Key? key,
      required this.text,
      this.iconData,
      this.controller,
      this.onChange,
      this.focusNode,
      this.hideText,
      this.errorText})
      : super(key: key);

  @override
  State<CustTextField> createState() => _CustTextFieldState();
}

class _CustTextFieldState extends State<CustTextField> {
  final CustColors _custColors = CustColors();
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText:
          (widget.hideText == null || widget.hideText == false) ? false : true,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: _custColors.primaryColor[0]),
        labelText: widget.text,
        prefixIcon: (widget.iconData != null) ? Icon(widget.iconData) : null,
        border: const OutlineInputBorder(),
        errorText: widget.errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _custColors.primaryColor[0],
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      onChanged: widget.onChange,
    );
  }
}
