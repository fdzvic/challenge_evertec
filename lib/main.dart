import 'package:challenge_evertec/app.dart';
import 'package:challenge_evertec/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/di/service_locator.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.serviceLocatorInit();
  runApp(const MyApp());
}
