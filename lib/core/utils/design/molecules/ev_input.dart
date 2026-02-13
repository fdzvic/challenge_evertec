import 'package:challenge_evertec/core/utils/helpers/validators.dart';
import 'package:flutter/material.dart';

enum InputValueType { email, phone, password, name, text }

class EvInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final InputValueType inputValueType;
  final String? matchValue;

  const EvInput({
    super.key,
    required this.controller,
    required this.label,

    this.inputValueType = InputValueType.text,
    this.matchValue,
  });

  @override
  State<EvInput> createState() => _EvInputState();
}

class _EvInputState extends State<EvInput> {
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  String? errorMessage;
  bool? showError = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration.zero, () {
      _defineObscureTextValue();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: _keyboardType(),
      obscureText: obscureText,
      validator: (x) => _validateInput(x ?? ''),
    );
  }

  void _defineObscureTextValue() {
    setState(() {
      obscureText = (widget.inputValueType == InputValueType.password);
    });
  }

  TextInputType _keyboardType() {
    switch (widget.inputValueType) {
      case InputValueType.email:
        return TextInputType.emailAddress;
      case InputValueType.password:
        return TextInputType.visiblePassword;
      case InputValueType.phone:
        return TextInputType.number;
      case InputValueType.text:
      case InputValueType.name:
        return TextInputType.text;
    }
  }

  String? _validateInput(String x) {
    _validate(x);
    setState(() {});
    return errorMessage;
  }

  String? _validate(String text) {
    switch (widget.inputValueType) {
      case InputValueType.email:
        errorMessage = validateEmail(text);
        break;
      case InputValueType.password:
        errorMessage = validatePassword(text, matchValue: widget.matchValue);
        break;
      case InputValueType.name:
        errorMessage = validateName(text, matchValue: widget.matchValue);
        break;

      case InputValueType.phone:
        errorMessage = validatePhone(text, matchValue: widget.matchValue);
        break;

      case InputValueType.text:
        errorMessage = noValidate();
        break;
    }
    showError = errorMessage != null;
    return errorMessage;
  }
}
