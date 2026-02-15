import 'package:challenge_evertec/core/utils/helpers/validators.dart';
import 'package:flutter/material.dart';

enum InputValueType { email, phone, password, name, text }

class EvInput extends StatefulWidget {
  const EvInput({
    super.key,
    required this.controller,
    required this.label,
    this.inputValueType = InputValueType.text,
    this.matchController,
    this.withValidator = true,
  });
  final TextEditingController controller;
  final String label;
  final InputValueType inputValueType;
  final TextEditingController? matchController;
  final bool withValidator;

  @override
  State<EvInput> createState() => _EvInputState();
}

class _EvInputState extends State<EvInput> {
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  String? errorMessage;
  bool showError = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });

    widget.controller.addListener(_onTextChanged);
    widget.matchController?.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _defineObscureTextValue();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    widget.matchController?.removeListener(_onTextChanged);
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
        errorText: showError == true ? errorMessage : null,
        suffixIcon: widget.inputValueType == InputValueType.password
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
      ),
      keyboardType: _keyboardType(),
      obscureText: obscureText,
      validator: widget.withValidator ? (value) => _validator(value) : null,
    );
  }

  String? _validator(String? value) {
    final error = _validate(value ?? '');

    setState(() {
      errorMessage = error;
      showError = error != null;
    });

    return error;
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

  String? _validate(String text) {
    switch (widget.inputValueType) {
      case InputValueType.email:
        return validateEmail(text);

      case InputValueType.password:
        return validatePassword(text, matchValue: widget.matchController?.text);

      case InputValueType.name:
        return validateName(text);

      case InputValueType.phone:
        return validatePhone(text);

      case InputValueType.text:
        return null;
    }
  }

  void _onTextChanged() {
    if (!widget.withValidator) return;

    final newError = _validate(widget.controller.text);

    if (newError != errorMessage) {
      setState(() {
        errorMessage = newError;
        showError = errorMessage != null;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
