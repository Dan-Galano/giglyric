import 'package:flutter/material.dart';
import 'package:galano_final_project/screens/homepage.dart';
import 'package:galano_final_project/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const GigLyricApp());
}

class GigLyricApp extends StatelessWidget {
  const GigLyricApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
