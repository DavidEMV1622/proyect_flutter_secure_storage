import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/sesion_iniciada_page.dart';

class AvisosPage  extends StatelessWidget {
  const AvisosPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Pantalla de avisos"),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InicioPage()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Siguiente pantalla'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}