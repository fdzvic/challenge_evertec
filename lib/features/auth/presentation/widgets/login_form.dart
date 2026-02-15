import 'package:challenge_evertec/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:challenge_evertec/core/utils/design/design.dart';
import 'package:challenge_evertec/features/auth/auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get _isFormFilled =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              EvInput(
                controller: _emailController,
                label: S.current.email,
                inputValueType: InputValueType.email,
              ),
              const SizedBox(height: 16),
              EvInput(
                controller: _passwordController,
                label: S.current.password,
                inputValueType: InputValueType.password,
                withValidator: false,
              ),
              const SizedBox(height: 24),
              EvButton(
                text: S.current.login,
                isLoading: isLoading,
                enabled: _isFormFilled && !isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().login(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              EvButton(
                text: S.current.register,
                enabled: !isLoading,
                onPressed: () {
                  context.push('/register');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
