import 'package:flutter/material.dart';
import 'package:infinistone/common/splash_screen.dart';
import 'package:infinistone/view/dashboard_view.dart';
import 'package:infinistone/view/login_view.dart';
import 'package:infinistone/view/registration_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegistrationView(),
        '/dashboard': (context) => const DashboardView(),
      },
    );
  }
}
