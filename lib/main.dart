import 'package:flutter/material.dart';
import 'package:infinistone/view/login_view.dart';
import 'package:infinistone/view/registration_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegistrationView(),
      },
    );
  }
}
