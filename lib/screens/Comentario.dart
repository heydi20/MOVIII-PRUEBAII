import 'package:app_prueba2/navigation/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Comentario extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<Comentario> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comentarios")),
      drawer: MiDrawer(),
      body: formulario()
    );
  }
}

Widget formulario() {
  TextEditingController _id = TextEditingController();
  TextEditingController _serie = TextEditingController();
  TextEditingController _comentario = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: _id,
        decoration: InputDecoration(labelText: "ID del comentario"),
      ),
      TextField(
        controller: _serie,
        decoration: InputDecoration(labelText: "Nombre de la serie"),
      ),
      TextField(
        controller: _comentario,
        decoration: InputDecoration(labelText: "Comentario"),
      ),
      FilledButton(
        onPressed: () => guardardatos(_id.text, _serie.text, _comentario.text),
        child: Text("Guardar"),
      ),
    ],
  );
}


Future<void> guardardatos(id,serie,comentario) async {
  final supabase = Supabase.instance.client;

  await supabase.from('series').insert({
    'id': id,
    'serie': serie,
    'comentario':comentario
  });
}
