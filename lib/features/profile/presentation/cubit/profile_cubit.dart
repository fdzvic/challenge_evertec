import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(ProfileInitial());

  Future<void> loadProfile(String uid) async {
    if (state is ProfileLoaded) return;
    emit(ProfileLoading());
    try {
      final profile = await getProfileUseCase(uid);
      emit(ProfileLoaded(profile));
    } catch (_) {
      emit(ProfileError());
    }
  }
}
