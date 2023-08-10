import 'package:flutter/material.dart';

class InicioPage  extends StatelessWidget {
  const InicioPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Pantalla de Inicio de sesion"),
          ],
        ),
      ),
    );
  }
}