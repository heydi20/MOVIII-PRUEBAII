import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Guardar extends StatelessWidget {
  const Guardar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: formulario());
  }
}

Widget formulario() {
  TextEditingController _id = TextEditingController();
  TextEditingController _serie = TextEditingController();
  TextEditingController _comentario = TextEditingController();

  return (Column(
    children: [
      TextField(controller: _id),
      TextField(controller: _serie),
      TextField(controller: _comentario),

      FilledButton(
        onPressed: () => guardardatos(_id.text, _serie.text, _comentario.text),
        child: Text("Guardar"),
      ),
    ],
  ));
}

Future<void> guardardatos(id,serie,comentario) async {
  final supabase = Supabase.instance.client;

  await supabase.from('series').insert({
    'id': id,
    'serie': serie,
    'comentario':comentario
  });
}