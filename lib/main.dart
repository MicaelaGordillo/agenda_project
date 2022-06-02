import 'package:agenda_project/screens/screen_actividades.dart';
import 'package:agenda_project/screens/screen_alarmas.dart';
import 'package:agenda_project/screens/screen_tareas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Agenda',
      home: ScreenAlarm(),
    );
  }
}
