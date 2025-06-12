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
    child: (Column(
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
        Container(height: 10),
        TextField(
          controller: _contrasenia,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Contrasenia"),
          ),
        ),

        ElevatedButton(
          onPressed: () => login(_correo.text, _contrasenia.text, context),
          child: Text("Login"),
        ),
      ],
    )),
  );
}

Future<void> login(String correo, String contrasenia, context) async {
  final supabase = Supabase.instance.client;
  final AuthResponse res = await supabase.auth.signInWithPassword(
    email: correo,
    password: contrasenia,
  );
  final Session? session = res.session;
  final User? user = res.user;

  print(user);
  if(user?.id!= null){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Comentario()));
  }
}