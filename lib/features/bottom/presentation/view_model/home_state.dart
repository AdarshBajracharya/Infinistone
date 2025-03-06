import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinistone/app/di/di.dart';
import 'package:infinistone/features/auth/presentation/view/profile_view.dart';
import 'package:infinistone/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:infinistone/features/home/presentation/view/dashboard_view.dart';
import 'package:infinistone/features/home/presentation/view_model/bookings_bloc.dart';
import 'package:infinistone/features/shop/presentation/view/shop_view.dart';
import 'package:infinistone/features/shop/presentation/view_model/shop_bloc.dart';
import 'package:infinistone/features/visualizer/presentation/view/visualizer_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<BookingsBloc>(),
          child: const BookingsPage(),
        ),
        BlocProvider(
          create: (context) => getIt<ShopBloc>(),
          child: const ShopView(),
        ),
        const WallAndFloorVisualizer(),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
          child: const ProfilePage(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
