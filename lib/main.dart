import 'package:challenge_evertec/app.dart';
import 'package:flutter/material.dart';
import 'core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.serviceLocatorInit();
  runApp(const MyApp());
}
