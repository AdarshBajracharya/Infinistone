import 'package:flutter/material.dart';
import 'package:infinistone/app/app.dart';
import 'package:infinistone/app/di/di.dart';
import 'package:infinistone/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    const MyApp(),
  );
}
