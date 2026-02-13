import 'package:challenge_evertec/core/utils/design/atoms/ev_switch.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_cubit.dart';
import '../../../../../core/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final brightness = MediaQuery.of(context).platformBrightness;
        final isDark = context.read<ThemeCubit>().isDarkMode(brightness);

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: ListTile(
            title: const Text('Dark Mode'),
            trailing: EvSwitch(
              value: isDark,
              onChanged: (value) {
                if (value) {
                  context.read<ThemeCubit>().setDarkMode();
                } else {
                  context.read<ThemeCubit>().setLightMode();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
