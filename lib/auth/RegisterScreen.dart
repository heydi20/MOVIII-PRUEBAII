import 'package:app_prueba2/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SUPABASE")),
      body: formularioRegistro(context),
    );
  }
}

Widget formularioRegistro(context) {
  TextEditingController _correo = TextEditingController();
  TextEditingController _contrasenia = TextEditingController();

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Registro", style: TextStyle(fontSize: 40)),
        TextField(
          controller: _correo,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Correo"),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _contrasenia,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Contraseña"),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => registrarse(_correo.text, _contrasenia.text, context),
          child: Text("Registrar"),
        ),
      ],
    ),
  );
}

Future<void> registrarse(String correo, String contrasenia, context) async {
  final supabase = Supabase.instance.client;

  try {
    final AuthResponse res = await supabase.auth.signUp(
      email: correo.trim(),
      password: contrasenia.trim(),
    );

    final Session? session = res.session;
    final User? user = res.user;

    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al registrar")));
    }
  } on AuthException catch (e) {
    // Aquí capturamos cualquier error de supabase
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
  } catch (e) {
    // Otros errores
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ocurrió un error")));
  }
}