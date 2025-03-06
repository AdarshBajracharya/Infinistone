// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:infinistone/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:infinistone/features/bottom/presentation/view_model/home_cubit.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:dartz/dartz.dart';
// import 'package:infinistone/features/auth/domain/use_case/login_usecase.dart';
// import 'package:infinistone/features/auth/presentation/view_model/login/login_bloc.dart';

// class MockLoginUseCase extends Mock implements LoginUseCase {}

// class MockRegisterBloc extends Mock implements RegisterBloc {
//   @override
//   Stream<RegisterState> get stream => Stream.empty();
// }

// class MockHomeCubit extends Mock implements HomeCubit {}

// class FakeBuildContext extends Fake implements BuildContext {}

// void main() {
//   late LoginBloc loginBloc;
//   late MockLoginUseCase mockLoginUseCase;
//   late BuildContext mockContext;

//   setUpAll(() {
//     registerFallbackValue(const LoginParams(email: '', password: ''));
//     registerFallbackValue(FakeBuildContext()); // Register FakeBuildContext
//   });

//   setUp(() {
//     mockLoginUseCase = MockLoginUseCase();
//     loginBloc = LoginBloc(
//       registerBloc: MockRegisterBloc(),
//       homeCubit: MockHomeCubit(),
//       loginUseCase: mockLoginUseCase,
//     );
//     mockContext = FakeBuildContext(); // Assign fake context
//   });

//   test('Initial state should be LoginState.initial()', () {
//     expect(loginBloc.state, LoginState.initial());
//   });

//   blocTest<LoginBloc, LoginState>(
//     'Emits loading and success when login is successful',
//     build: () {
//       when(() => mockLoginUseCase(any()))
//           .thenAnswer((_) async => const Right("fake_token"));
//       return loginBloc;
//     },
//     act: (bloc) => bloc.add(
//       LoginUserEvent(
//         context: mockContext, // Pass the fake context
//         email: "test@example.com",
//         password: "password123",
//       ),
//     ),
//     expect: () => [
//       LoginState.initial().copyWith(isLoading: true),
//       LoginState.initial().copyWith(isLoading: false, isSuccess: true),
//     ],
//   );
// }
