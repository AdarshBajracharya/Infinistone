import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinistone/app/di/di.dart';
import 'package:infinistone/features/auth/presentation/view/login_view.dart';
import 'package:infinistone/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:infinistone/features/home/presentation/view_model/dashboard_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: const LoginView(),
            ),
          ),
        );
      }
    });
  }
}
