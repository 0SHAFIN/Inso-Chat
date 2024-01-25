import 'package:flutter/material.dart';
import 'package:inso_chat/component/assets/colors.dart';

class inputField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  var keyType;
  bool obscureText;
  IconData? icon;
  var validator;
  inputField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.validator,
      this.keyType,
      this.obscureText = false,
      this.icon});

  @override
  State<inputField> createState() => _inputFieldState();
}

class _inputFieldState extends State<inputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyType,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        label: Text(widget.hint.toString()),
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        filled: true,
        fillColor: Clr.inputfieldFiller,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
