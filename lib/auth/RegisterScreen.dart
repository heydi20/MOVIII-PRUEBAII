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

    final User? user = res.user;

    if (user != null) {
      mostrarAlerta(
        context,
        "Registro exitoso",
        "Usuario registrado correctamente",
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      mostrarAlerta(context, "Error", "No se pudo registrar el usuario.");
    }
  } on AuthException catch (e) {
    String mensajeError = traducirError(e.message);
    mostrarAlerta(context, "Error de registro", mensajeError);
  } catch (e) {
    mostrarAlerta(context, "Error", "Ocurrió un error inesperado");
  }
}

String traducirError(String mensajeOriginal) {
  // Lo pasamos a minúsculas para evitar problemas de mayúsculas
  mensajeOriginal = mensajeOriginal.toLowerCase();

  if (mensajeOriginal.contains("password should be at least 6 characters")
      || mensajeOriginal.contains("password should be at least 6 characters long")) {
    return "La contraseña debe tener al menos 6 caracteres.";
  } else if (mensajeOriginal.contains("user already registered")) {
    return "El correo ya está registrado.";
  } else if (mensajeOriginal.contains("invalid email format")) {
    return "El formato del correo no es válido.";
  } else {
    return "Ocurrió un error ingresar correctamente las credenciales";
  }
}

void mostrarAlerta(context, String titulo, String mensaje) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cerrar"),
          ),
        ],
      );
    },
  );
}
