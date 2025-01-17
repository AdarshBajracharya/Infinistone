import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinistone/app/di/di.dart';
import 'package:infinistone/core/theme/app_theme.dart';
import 'package:infinistone/features/splash/presentation/view/splash_screen.dart';
import 'package:infinistone/features/splash/presentation/view_model/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Infinistone',
      theme: getApplicationTheme(),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashScreen(),
      ),
    );
  }
}
