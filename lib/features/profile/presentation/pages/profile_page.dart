import 'package:challenge_evertec/core/utils/design/design.dart';
import 'package:challenge_evertec/core/utils/ui/confim_bottom_sheet.dart';
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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            final profile = state.profile;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EvAppBar(
                      title: '${profile.firstName} ${profile.lastName}',
                      icon: Icons.person,
                      viewIconSearch: false,
                    ),
                    const SizedBox(height: 8),
                    Text(profile.email),
                    Text(profile.phone),
                    const SizedBox(height: 32),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, themeState) {
                        final isDark = themeState.themeMode == ThemeMode.dark;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            final confirm = await showConfirmLogoutSheet(
                              context,
                              title: '¿Cerrar sesión?',
                              subtitle: 'Tendrás que iniciar sesión nuevamente para usar la app.',
                            );
                            if (!context.mounted) return;
                            if (confirm == true) {
                              context.read<AuthCubit>().logout();
                            }
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Cerrar Sesión'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Error al cargar perfil'));
        },
      ),
    );
  }
}
