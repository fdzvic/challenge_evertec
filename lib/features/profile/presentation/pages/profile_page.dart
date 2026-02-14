import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/theme.dart';
import '../../../auth/auth.dart';
import '../cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }

    return BlocProvider(
      create: (_) =>
          getIt<ProfileCubit>()..loadProfile(authState.user.id),
      child: Scaffold(
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
      ),
    );
  }
}
