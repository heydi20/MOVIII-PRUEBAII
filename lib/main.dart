import 'package:app_prueba2/screens/WelcomScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
   await Supabase.initialize(
    url: 'https://jxdutosynkvytlixypuv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp4ZHV0b3N5bmt2eXRsaXh5cHV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk2NDQzNzgsImV4cCI6MjA2NTIyMDM3OH0.bbEY1L0iRPaJBXgbmK0CRc0P1vMwyWsBjTWVfIL6Ft4',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Welcome(),
        ),
      ),
    );
  }
}
