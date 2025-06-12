import 'package:app_prueba2/screens/Comentario.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SUPABASE")),
      body: formularioLogin(context),
    );
  }
}

Widget formularioLogin(context) {
  TextEditingController _correo = TextEditingController();
  TextEditingController _contrasenia = TextEditingController();

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("LOGIN", style: TextStyle(fontSize: 40)),
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
          onPressed: () => login(_correo.text, _contrasenia.text, context),
          child: Text("Login"),
        ),
      ],
    ),
  );
}

Future<void> login(String correo, String contrasenia, context) async {
  final supabase = Supabase.instance.client;

  if (correo.trim().isEmpty || contrasenia.trim().isEmpty) {
    mostrarAlerta(context, "Campos vacíos", "Por favor ingrese correo y contraseña.");
    return;
  }

  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: correo.trim(),
      password: contrasenia.trim(),
    );

    final User? user = res.user;

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Comentario()),
      );
    } else {
      mostrarAlerta(context, "Error", "No se pudo iniciar sesión.");
    }
  } on AuthException catch (e) {
    String mensajeError = traducirError(e.message);
    mostrarAlerta(context, "Error de autenticación", mensajeError);
  } catch (e) {
    mostrarAlerta(context, "Error", "Ocurrió un error inesperado.");
  }
}

String traducirError(String mensajeOriginal) {
  mensajeOriginal = mensajeOriginal.toLowerCase();

  if (mensajeOriginal.contains("invalid login credentials")) {
    return "Correo o contraseña incorrectos.";
  } else if (mensajeOriginal.contains("invalid email")) {
    return "El formato del correo es inválido.";
  } else if (mensajeOriginal.contains("network")) {
    return "Problema de conexión. Verifique su red.";
  } else {
    return "Ocurrió un error: $mensajeOriginal";
  }
}

// Alert dialog reutilizable
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
