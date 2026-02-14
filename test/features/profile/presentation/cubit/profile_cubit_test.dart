import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:challenge_evertec/features/profile/domain/entities/profile_entity.dart';
import 'package:challenge_evertec/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:challenge_evertec/features/profile/presentation/cubit/profile_cubit.dart';

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

void main() {
  late ProfileCubit cubit;
  late MockGetProfileUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetProfileUseCase();
    cubit = ProfileCubit(mockUseCase);
  });

  blocTest<ProfileCubit, ProfileState>(
    'emits [Loading, Loaded] when profile loads successfully',
    build: () {
      when(() => mockUseCase('123')).thenAnswer(
        (_) async => ProfileEntity(
          id: '123',
          firstName: 'Victor',
          lastName: 'Perez',
          email: 'victor@mail.com',
          phone: '123456',
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.loadProfile('123'),
    expect: () => [isA<ProfileLoading>(), isA<ProfileLoaded>()],
  );

  blocTest<ProfileCubit, ProfileState>(
    'emits [Loading, Error] when profile loading fails',
    build: () {
      when(() => mockUseCase('123')).thenThrow(Exception());
      return cubit;
    },
    act: (cubit) => cubit.loadProfile('123'),
    expect: () => [isA<ProfileLoading>(), isA<ProfileError>()],
  );
  blocTest<ProfileCubit, ProfileState>(
    'calls usecase with correct uid',
    build: () {
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => ProfileEntity(
          id: '123',
          firstName: 'Victor',
          lastName: 'Perez',
          email: 'victor@mail.com',
          phone: '123456',
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.loadProfile('123'),
    verify: (_) {
      verify(() => mockUseCase('123')).called(1);
    },
  );
}
