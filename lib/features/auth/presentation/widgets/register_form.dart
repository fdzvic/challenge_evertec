import 'package:challenge_evertec/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/design/design.dart';
import '../../auth.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              EvInput(
                controller: _firstNameController,
                label: S.current.name,
                inputValueType: InputValueType.name,
              ),
              const SizedBox(height: 16),
              EvInput(
                controller: _lastNameController,
                label: S.current.lastName,
                inputValueType: InputValueType.name,
              ),
              const SizedBox(height: 16),
              EvInput(
                controller: _phoneController,
                label:S.current.phone,
                inputValueType: InputValueType.phone,
              ),
              const SizedBox(height: 16),
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
              ),
              const SizedBox(height: 16),
              EvInput(
                controller: _confirmPasswordController,
                label: S.current.confirmPassword,
                inputValueType: InputValueType.password,
                matchValue: _passwordController.text,
              ),
              const SizedBox(height: 24),
              EvButton(
                text: S.current.register,
                isLoading: isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().register(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      phone: _phoneController.text.trim(),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              EvButton(
                text: S.current.haveAccount,
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
