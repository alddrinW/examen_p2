import 'package:flutter/material.dart';
import 'screens/galeria_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galería App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GaleriaScreen(),
    );
  }
}
