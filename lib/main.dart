import 'package:challenge_evertec/app.dart';
import 'package:challenge_evertec/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:challenge_evertec/core/di/service_locator.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  await di.serviceLocatorInit();
  runApp(const MyApp());
}
