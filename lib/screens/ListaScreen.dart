import 'dart:convert';

import 'package:app_prueba2/navigation/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Series")),
      drawer: MiDrawer(),
      body: lista(),
    );
  }
}

Future<List> leerJson() async {
  final respuesta = await http.get(
    Uri.parse("https://jritsqmet.github.io/web-api/series.json"),
  );

  final data = json.decode(respuesta.body);
  return data['series'];
}

Widget lista() {
  return FutureBuilder(
    future: leerJson(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasData) {
        final data = snapshot.data!;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text(item['titulo']),
              subtitle: Text(item['descripcion']),
              leading: Image.network(
                item['info']['imagen'],
               
              ),
              onTap: () => (),
            );
            
          },
        );
      } else {
        return Text("NO HAY DATA");
      }
    },
  );
}

/**ana@gmail.com */
