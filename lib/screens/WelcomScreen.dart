import 'package:app_prueba2/auth/LoginScreen.dart';
import 'package:app_prueba2/auth/RegisterScreen.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Desarrollador: Heydi Herrera"),
              Text("GitHub: heydi20"),
              btnLogin(context),
              btnRegistro(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget btnLogin(BuildContext context) {
  return ElevatedButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    ),
    child: Text("Ir a Login"),
  );
}

Widget btnRegistro(context) {
  return (ElevatedButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registro()),
    ),
    child: Text("Ir a Registro"),
  ));
}
