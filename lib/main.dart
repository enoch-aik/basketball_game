
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball game',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
        home: const SplashScreen(),
    );
  }
}

