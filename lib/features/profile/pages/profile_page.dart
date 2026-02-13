import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/design/atoms/atoms.dart';

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
