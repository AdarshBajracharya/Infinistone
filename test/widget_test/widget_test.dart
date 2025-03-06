import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinistone/features/auth/presentation/view/login_view.dart';
import 'package:infinistone/features/splash/presentation/view/onboarding_screen.dart';
import 'package:infinistone/features/splash/presentation/view_model/onboarding_cubit.dart';

void main() {
  testWidgets('Displays welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.text("Welcome Back"), findsOneWidget);
  });

  testWidgets('Displays login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets('Displays registration prompt', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.text("Don't have an account? Register now."), findsOneWidget);
  });

  testWidgets('Displays forgot password option', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.text("Forgot your password?"), findsOneWidget);
  });

  testWidgets('Has two input fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Can enter email and password', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    await tester.enterText(find.byType(TextField).first, "test@example.com");
    await tester.enterText(find.byType(TextField).last, "password123");

    expect(find.text("test@example.com"), findsOneWidget);
    expect(find.text("password123"), findsOneWidget);
  });

  testWidgets('renders correctly',
      (WidgetTester tester) async {
    // Build the OnboardingScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    // Verify that the first onboarding page is rendered
    expect(find.text('Welcome to Infinistone'), findsOneWidget);
    expect(
      find.text('Your ultimate destination for premium tiles and stones.'),
      findsOneWidget,
    );
  });

  testWidgets('shows correct page indicators',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    // Verify that there are 3 page indicators (dots)
    expect(find.byType(Container), findsNWidgets(3));
  });

  testWidgets('navigates to the next page on button press',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    // Tap the next button
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify that the second page is displayed
    expect(find.text('Discover Endless Options'), findsOneWidget);
  });

  testWidgets('toggles dark mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    // Tap the theme toggle button
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pump();

    // Verify that the theme has changed
    expect(find.byIcon(Icons.light_mode),
        findsOneWidget); // Icon changes to light mode
  });
}
