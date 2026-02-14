import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge_evertec/core/theme/theme.dart';
import 'package:challenge_evertec/features/auth/auth.dart';
import 'package:challenge_evertec/features/profile/presentation/cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
    
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (state is ProfileLoaded) {
            final profile = state.profile;
    
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(profile.email),
                  Text(profile.phone),
                  const SizedBox(height: 32),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, themeState) {
                      final isDark =
                          themeState.themeMode == ThemeMode.dark;
    
                      return SwitchListTile(
                        title: const Text('Modo Oscuro'),
                        value: isDark,
                        onChanged: (value) {
                          if (value) {
                            context.read<ThemeCubit>().setDarkMode();
                          } else {
                            context.read<ThemeCubit>().setLightMode();
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Cerrar Sesión'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Error al cargar perfil'));
        },
      ),
    );
  }
}
