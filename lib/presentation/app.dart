import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/prueba_secure_storage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // widget principal
      home: Center(
        child: HomePage(),
      ),
    );
  }
}