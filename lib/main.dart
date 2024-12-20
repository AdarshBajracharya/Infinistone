import 'package:flutter/material.dart';
import 'package:infinistone/core/app_theme/app_theme.dart';
import 'package:infinistone/core/common/splash_screen.dart';
import 'package:infinistone/view/dashboard_view.dart';
import 'package:infinistone/view/login_view.dart';
import 'package:infinistone/view/onboarding_screen.dart';
import 'package:infinistone/view/registration_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegistrationView(),
        '/dashboard': (context) => DashboardView(),
      },
    );
  }
}
