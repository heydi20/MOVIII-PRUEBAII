import 'package:app_prueba2/screens/Comentario.dart';
import 'package:app_prueba2/screens/ListaScreen.dart';
import 'package:flutter/material.dart';


class MiDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menú")),
          ListTile(
            title: Text("Comentarios"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Comentario()));
            },
          ),
          ListTile(
            title: Text("Lista de Series"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Lista()));
            },
          ),
        ],
      ),
    );
  }
}
