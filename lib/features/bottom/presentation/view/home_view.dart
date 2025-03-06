import 'dart:math'; // To use sqrt for magnitude calculation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinistone/core/common/snackbar/my_snackbar.dart';
import 'package:infinistone/features/bottom/presentation/view_model/home_cubit.dart';
import 'package:infinistone/features/bottom/presentation/view_model/home_state.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bool _isDarkTheme = false;
  final double _shakeThreshold = 15.0; 
  final List<double> _accelerometerValues = [];

  @override
  void initState() {
    super.initState();
    // Listen for user accelerometer changes
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      // Calculate the magnitude of the acceleration
      double magnitude =
          sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));

      // Check if the magnitude exceeds the shake threshold
      if (magnitude > _shakeThreshold) {
        _onShake();
      }
    });
  }

  void _onShake() {
    // Handle the logout on shake
    showMySnackBar(
      context: context,
      message: 'Logging out...',
      color: Colors.red,
    );
    context.read<HomeCubit>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinistone', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.red,
              );
              context.read<HomeCubit>().logout(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.remove_red_eye),
                label: 'Visualizer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            backgroundColor: Colors.black,
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}